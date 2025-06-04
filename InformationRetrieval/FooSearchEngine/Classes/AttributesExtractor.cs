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
    public abstract class AttributesExtractor : IAttributesExtractor
    {
        public List<string>? _globalVector;
        public List<Document>? _documents;

        protected List<string> _stopWords = new List<string>();
        protected string stopWordsFile = Path.GetFullPath(
                                Path.Combine(AppContext.BaseDirectory, @"..\..\..\Utils\stopwords.txt"));

        /// <summary>
        /// Instantiates internal global and frequency vectors.
        /// </summary>
        public AttributesExtractor()
        {
            _globalVector = new List<string>();
            _documents = new List<Document>();
        }
        /// <summary>
        /// Parses the givent data and sets the
        /// global and frequency vectors.
        /// </summary>
        public abstract void ParseData();
        /// <summary>
        /// Sets the stop words used in filtering out
        /// the attributes based on given input file.
        /// </summary>
        /// <param name="filePath"></param>
        protected void SetStopWords(string filePath)
        {
            _stopWords = new List<string>();
            foreach (string line in File.ReadLines(filePath))
                _stopWords.Add(line);

        }
        /// <summary>
        /// Filters the raw extracted words.
        /// </summary>
        /// <param name="rawWords"></param>
        /// <param name="document"></param>
        protected void FilterList(List<string> rawWords, Document document)
        {
            int size = rawWords.Count;

            for (int i = size - 1; i >= 0; i--)
            {
                rawWords[i] = Regex.Replace(rawWords[i], @"[\p{P}\p{S}\d\t]", ""); //remove unimportant symbols

                if (_stopWords.Contains(rawWords[i]))
                    rawWords.RemoveAt(i);
                else
                {
                    PorterStemmer porterStemmer = new PorterStemmer();
                    string processedWord = porterStemmer.StemWord(rawWords[i]);

                    if (!_globalVector.Contains(processedWord))
                    {
                        _globalVector.Add(processedWord);

                        document.AddNewEntry(_globalVector.IndexOf(processedWord));
                    }

                    else
                        document.CheckWordFrequencyVector(_globalVector.IndexOf(processedWord));
                }
            }
        }
        public List<Document> GetDocuments()
        {
            return _documents;
        }
        public List<string> GetGlobalVector()
        {
            return _globalVector;
        }
    }
}
