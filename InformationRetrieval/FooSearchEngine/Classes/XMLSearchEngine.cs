using FooSearchEngine.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FooSearchEngine.Classes
{
    class XMLSearchEngine
    {
        string[] _inputFilesPaths;
        List<string> _globalVector;
        List<string> _labels;
        List<Document> _documents;
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
        }
        public Dictionary<string,float> Search(List<string> query)
        {
            List<Document> queryDoc = new List<Document>();
            Dictionary<Document, float> distances = new Dictionary<Document, float>();

            _attributesExtractor.ParseData();
            _documents = _attributesExtractor.GetDocuments();

            _globalVector = _attributesExtractor.GetGlobalVector();
            _attributesPreprocessor.FilterAttributes(_globalVector, _documents);

            _attributesExtractor = new TXTExtractor(query);
            _attributesExtractor.ParseData();
            queryDoc = _attributesExtractor.GetDocuments();
            _vectorNormalizer.NormalizeVectors(_globalVector, _documents);
            _vectorNormalizer.NormalizeVectors(_globalVector, queryDoc);

            foreach (Document doc in _documents)
            {
                distances.Add(doc, ComputeDistance(doc, queryDoc[0]));
            }
            var sortedResults = distances.OrderBy(pair => pair.Value).ToList();
            Dictionary<string, float> topResults = new Dictionary<string, float>();
            for (int i = 0; i < 3; i++)
                topResults.Add(sortedResults[i].Key.FileName, sortedResults[i].Value);

            return topResults;
        }
        private float ComputeDistance(Document doc0, Document doc1)
        {
            float distance = 0;
            for (int i = 0; i < doc0.FrequencyVector.Count; i++)
                distance += Math.Abs(doc0.FrequencyVector[i] - doc1.FrequencyVector[i]);
            return distance;
        }

    }
}
