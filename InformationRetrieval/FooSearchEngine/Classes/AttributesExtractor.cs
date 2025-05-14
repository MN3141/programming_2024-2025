using FooSearchEngine.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Xml;
using WordFrequency;

namespace FooSearchEngine.Classes
{
    /// <summary>
    /// Responsible for extracting relevant attributes from all given XML files.
    /// </summary>
    public class AttributesExtractor : IAttributesExtractor
    {
        List<string> _stopWords = new List<string>();
        List<string> _gatheredLabels = new List<string>();
        string stopWordsFile = Path.GetFullPath(
                                Path.Combine(AppContext.BaseDirectory, @"..\..\..\Utils\stopwords.txt"));
        List<string>? _globalVector;
        private void SetStopWords(string filePath)
        {
            this._stopWords = new List<string>();
            foreach (string line in File.ReadLines(filePath))
                this._stopWords.Add(line);

        }

        /// <summary>
        /// Parse all of the given XML files for attributes.
        /// </summary>
        /// <param name="inputFilesPaths"></param>
        /// <param name="globalVector"></param>
        /// <returns>
        /// Returns a list of parsed documents with updated frequency and global vectors
        /// and sets the values for global vector.
        /// </returns>
        public List<Document> ParseDocuments(string[] inputFilesPaths, List<string> globalVector)
        {
            this._globalVector = globalVector;
            List<Document> parsedDocuments = new List<Document>();
            SetStopWords(stopWordsFile);
            for (int i = 0; i < inputFilesPaths.Length; i++)
            {
                Document document = new Document(inputFilesPaths[i]);
                this.ParseDocument(document);
                parsedDocuments.Add(document);
            }
            return parsedDocuments;
        }

        private void ParseDocument(Document document)
        {
            using (XmlReader reader = XmlReader.Create(document.FileName))
            {
                while (reader.Read())
                {
                    if (reader.NodeType == XmlNodeType.Element && reader.Name == "title")
                    {
                        reader.Read(); // Move to the text node (inside <title>)
                        document.Title = reader.Value;
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
                                FilterList(ref rawWords, ref document);

                            }
                            else if (reader.NodeType == XmlNodeType.EndElement && reader.Name == "text")
                                break; // We are only interested in the document title and it's text;

                        }
                    }
                    else if (reader.NodeType == XmlNodeType.Element && reader.Name == "codes" && reader.GetAttribute("class") == "bip:topics:1.0"){
                        // Get the document label/class/topic
                        while (reader.Read()){
                                if (reader.NodeType == XmlNodeType.Element && reader.Name == "code")
                                {
                                    string topic = reader.GetAttribute("code");
                                    document.Topic = topic;
                                    break;
                                }
                            }
                    }
                }
            }
        }

        private void FilterList(ref List<string> rawWords, ref Document document)
        {
            int size = rawWords.Count;

            for (int i = size - 1; i >= 0; i--)
            {
                rawWords[i] = Regex.Replace(rawWords[i], @"[\p{P}\p{S}\d]", ""); //remove unimportant symbols

                if (this._stopWords.Contains(rawWords[i]))
                    rawWords.RemoveAt(i);
                else
                {
                    PorterStemmer porterStemmer = new PorterStemmer();
                    string processedWord = porterStemmer.StemWord(rawWords[i]);

                    if (!this._globalVector.Contains(processedWord))
                    {
                        this._globalVector.Add(processedWord);

                        document.AddNewEntry(this._globalVector.IndexOf(processedWord));
                    }

                    else
                        document.CheckWordFrequencyVector(this._globalVector.IndexOf(processedWord));
                }
            }
        }
    }
}
