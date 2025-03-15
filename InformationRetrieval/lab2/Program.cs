using System;
using System.Collections;
using System.IO;
using System.Xml; 
class SearchEngine
{
    string _outputDir;

    List<String> _inputFilePaths, _stopWords;
    private void removeStopWord(string stopWord) { }

    private void dumpFile(string filePath)
    {

    }
    private void parseDocument(Document doc)
    {


        using (XmlReader reader = XmlReader.Create(doc.GetFileName()))
        {
            while (reader.Read())
            {
                if (reader.NodeType == XmlNodeType.Element && reader.Name == "title")
                {
                    reader.Read(); // Move to the text node (inside <title>)
                    doc.SetDocumentTitle(reader.Value);
                    Console.WriteLine("TITLE " + reader.Value);
                }
                else if (reader.NodeType == XmlNodeType.Element && reader.Name == "text")
                {
                        // break; //We are only interested in the document title and it's text
                }
            }
        }
    }

    public void ParseDocuments()
    {
        foreach(string file in this._inputFilePaths)
        {
            Document doc = new Document(file);
            parseDocument(doc);
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
    }
}