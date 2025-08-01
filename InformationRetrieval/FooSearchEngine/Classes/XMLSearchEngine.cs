using FooSearchEngine.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Diagnostics;


namespace FooSearchEngine.Classes
{
    class XMLSearchEngine
    {
        string[] _inputFilesPaths;
        List<string> _globalVector;
        List<string> _labels;
        List<Document> _documents;
        List<Document> _queryDoc = new List<Document>();
        Dictionary<Document, float> _distances = new Dictionary<Document, float>();
        Stopwatch _stopwatch;
        IAttributesExtractor _attributesExtractor;
        IAttributesPreprocessor _attributesPreprocessor;
        IVectorNormalizer _vectorNormalizer;

        /// <summary>
        /// Constructor using files from a given directory
        /// </summary>
        /// <param name="inputFilesDir"></param>
        public XMLSearchEngine(string inputFilesDir)
        {
            _inputFilesPaths = Directory.GetFiles(inputFilesDir);
            _globalVector = new List<string>();
            _documents = new List<Document>();
            _attributesExtractor = new XMLExtractor(inputFilesDir);
            _attributesPreprocessor = new AttributesPreprocessor();
            _vectorNormalizer = new VectorNormalizer();
            _stopwatch = new Stopwatch();

            _stopwatch.Start();

            _attributesExtractor.ParseData();
            _documents = _attributesExtractor.GetDocuments();
            _globalVector = _attributesExtractor.GetGlobalVector();

            _stopwatch.Stop();
            Console.WriteLine("XML extraction took {0} minutes, {1} seconds and {2} miliseconds.", _stopwatch.Elapsed.Minutes, _stopwatch.Elapsed.Seconds, _stopwatch.Elapsed.Milliseconds);

            _stopwatch.Start();
            _attributesPreprocessor.FilterAttributes(_globalVector, _documents);
            _stopwatch.Stop();
            Console.WriteLine("Vector filtering took {0} minutes, {1} seconds and {2} miliseconds.", _stopwatch.Elapsed.Minutes, _stopwatch.Elapsed.Seconds, _stopwatch.Elapsed.Milliseconds);

            _stopwatch.Start();
            _vectorNormalizer.NormalizeVectors(_globalVector, _documents);
            _stopwatch.Stop();
            Console.WriteLine("Vector normalization took {0} minutes, {1} seconds and {2} miliseconds.", _stopwatch.Elapsed.Minutes, _stopwatch.Elapsed.Seconds, _stopwatch.Elapsed.Milliseconds);

        }

        /// <summary>
        /// Constructor using absolute paths for files that can be in different directories
        /// </summary>
        /// <param name="inputFilesPaths"></param>
        public XMLSearchEngine(string[] inputFilesPaths)
        {
            _inputFilesPaths = inputFilesPaths;
            _globalVector = new List<string>();
            _documents = new List<Document>();
            _attributesExtractor = new XMLExtractor(inputFilesPaths);
            _attributesPreprocessor = new AttributesPreprocessor();
            _vectorNormalizer = new VectorNormalizer();
            _stopwatch = new Stopwatch();

            _stopwatch.Start();

            _attributesExtractor.ParseData();
            _documents = _attributesExtractor.GetDocuments();
            _globalVector = _attributesExtractor.GetGlobalVector();

            _stopwatch.Stop();
            Console.WriteLine("XML extraction took {0} minutes, {1} seconds and {2} miliseconds.", _stopwatch.Elapsed.Minutes, _stopwatch.Elapsed.Seconds, _stopwatch.Elapsed.Milliseconds);

            _stopwatch.Start();
            _attributesPreprocessor.FilterAttributes(_globalVector, _documents);
            _stopwatch.Stop();
            Console.WriteLine("Vector filtering took {0} minutes, {1} seconds and {2} miliseconds.", _stopwatch.Elapsed.Minutes, _stopwatch.Elapsed.Seconds, _stopwatch.Elapsed.Milliseconds);

            _stopwatch.Start();
            _vectorNormalizer.NormalizeVectors(_globalVector, _documents);
            _stopwatch.Stop();
            Console.WriteLine("Vector normalization took {0} minutes, {1} seconds and {2} miliseconds.", _stopwatch.Elapsed.Minutes, _stopwatch.Elapsed.Seconds, _stopwatch.Elapsed.Milliseconds);

        }
        public void Search(string query)
        {
            _queryDoc.Clear();
            _distances.Clear();

            _stopwatch.Start();
            _attributesExtractor = new TXTExtractor(query);
            _attributesExtractor.ParseData();
            _queryDoc = _attributesExtractor.GetDocuments();
            _vectorNormalizer.NormalizeVectors(_globalVector, _queryDoc);

            foreach (Document doc in _documents)
            {
                _distances.Add(doc, ComputeDistance(doc, _queryDoc[0]));
            }
            var sortedResults = _distances.OrderBy(pair => pair.Value).ToList();
            Dictionary<string, float> topResults = new Dictionary<string, float>();
            for (int i = 0; i < 3; i++)
                Console.WriteLine("{0} : {1}",sortedResults[i].Key.FileName, sortedResults[i].Value);

            _stopwatch.Stop();
            Console.WriteLine("Query processing took {0} minutes, {1} seconds and {2} miliseconds.", _stopwatch.Elapsed.Minutes, _stopwatch.Elapsed.Seconds, _stopwatch.Elapsed.Milliseconds);
        }
        private float ComputeDistance(Document doc0, Document doc1)
        {
            float distance = 0;
            foreach (int key in doc0.FrequencyVector.Keys)
                {
                    if (doc1.FrequencyVector.ContainsKey(key))
                        distance += Math.Abs(doc0.FrequencyVector[key] - doc1.FrequencyVector[key]);
                    else
                        distance += Math.Abs(doc0.FrequencyVector[key]);
                }
            return distance;
        }

    }
}
