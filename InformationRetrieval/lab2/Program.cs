using System;
using System.Collections;
using System.IO;
using System.Xml;
using System.Globalization;
using System.Text.RegularExpressions;
using PorterStemmer = WordFrequency.PorterStemmer;
class SearchEngine
{
    string _outputDir;

    List<String> _inputFilePaths, _stopWords;

    private void FilterList(ref List<string> unfilteredWords, ref Document doc)
    {

        int size = unfilteredWords.Count;
        
        for(int i = size - 1; i >= 0; i--)
        {
            unfilteredWords[i] = Regex.Replace(unfilteredWords[i], @"\p{P}", ""); //remove punctuation marks

            if (this._stopWords.Contains(unfilteredWords[i]))
                unfilteredWords.RemoveAt(i);
            else
            {
                PorterStemmer porterStemmer = new PorterStemmer();
                string processedWord = porterStemmer.StemWord(unfilteredWords[i]);
                doc.CheckWordGlobalVector(processedWord);
                doc.CheckWordFrequencyVector(processedWord);
            }
        }
    }

    private void DumpFile(ref Document doc, string filePath)
    {
        if (!Directory.Exists(this._outputDir))
        {
            Directory.CreateDirectory(this._outputDir);
        }

        using (StreamWriter writer = new StreamWriter(filePath))
        {

            List<String> globalVector = doc.GetGlobalVector();
            List< Dictionary<int, int> > freqVector = doc.GetFrequencyVector();

            writer.WriteLine(doc.GetFileName());
            writer.WriteLine(doc.GetDocumentTitle());

            foreach (string word in globalVector)
                writer.Write(word + ", ");

            foreach (Dictionary<int,int> dict in freqVector)
            {
                foreach (var kvp in dict)
                {
                    writer.Write($"Key: {kvp.Key}, Value: {kvp.Value}");
                }
            }
        }
    }
    private void ParseDocument(Document doc)
    {


        using (XmlReader reader = XmlReader.Create(doc.GetFileName()))
        {
            while (reader.Read())
            {
                if (reader.NodeType == XmlNodeType.Element && reader.Name == "title")
                {
                    reader.Read(); // Move to the text node (inside <title>)
                    doc.SetDocumentTitle(reader.Value);
                }
                else if (reader.NodeType == XmlNodeType.Element && reader.Name == "text")
                {
                    while (reader.Read())
                    {
                        // Check for the <p> tags inside <text>
                        if (reader.NodeType == XmlNodeType.Element && reader.Name == "p")
                        {
                            string paragraph = reader.ReadElementContentAsString();
                            List<string> rawWords = paragraph.ToLower().Split(" ").ToList();
                            FilterList(ref rawWords, ref doc);
                             
                        }
                        else if (reader.NodeType == XmlNodeType.EndElement && reader.Name == "text")
                            break; //We are only interested in the document title and it's text;

                    }
                }
            }
        }

        DumpFile(ref doc, doc.GetDocumentOutputFile());
    }

    public void ParseDocuments()
    {
        foreach(string file in this._inputFilePaths)
        {
            Document doc = new Document(file);

            string[] docName = file.Split(new char[] { '.', '\\' });
            doc.SetOutputFileName(this._outputDir + "\\" + docName[docName.Length - 2] + ".txt");
            ParseDocument(doc);
        }
    }
    public void SetStopWords(string filePath)
    {
        this._stopWords = new List<string>();
        foreach (string line in File.ReadLines(filePath))
        {
            this._stopWords.Add(line);
        }
    }

    public void SetOutputDir(string directory)
    {
        this._outputDir = directory;
    }

    public SearchEngine(List<string> filePaths)
    {
        this._inputFilePaths = filePaths;
    }
}
class Program
{
    static void Main()
    {
        DateTime startTime = DateTime.Now;
        string appDir = Directory.GetParent(Environment.CurrentDirectory).Parent.Parent.FullName;
        string stopWordsFile = appDir + "\\stopwords.txt";
        string inputDir = appDir + "\\..\\Reuters_34\\Training";

        DirectoryInfo inputDirInfo = new DirectoryInfo(inputDir);
        FileInfo [] filesInfo = inputDirInfo.GetFiles();
        List<String> inputPaths = new();
        foreach(FileInfo file in filesInfo)
        {
            inputPaths.Add(file.FullName);
        }

        SearchEngine docProc = new SearchEngine(inputPaths);
        docProc.SetOutputDir(appDir);
        docProc.SetStopWords(stopWordsFile);
        docProc.ParseDocuments();

        Console.WriteLine("Process took " + (DateTime.Now.Millisecond - startTime.Millisecond).ToString() + " miliseconds");
    }
}