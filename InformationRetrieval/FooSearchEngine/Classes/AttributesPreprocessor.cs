using FooSearchEngine.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FooSearchEngine.Classes
{
    class AttributesPreprocessor : IAttributesPreprocessor
    {
        private double _threshold;
        private int _sampleSize;
        private double _wholeEntropy;
        private List<int> _documentSetWeights;
        public List<Document> _inputDocs { get; set; }
        public List<string> _inputGlobalVector { get; set; }
        Dictionary<string, int> _counterPresent;
        Dictionary<string, int> _counterMissing;

        public AttributesPreprocessor()
        {

            _threshold = 0.0009f;
            _inputDocs = new List<Document>();
            _inputGlobalVector = new List<string>();
            _documentSetWeights = new List<int>();
            _counterMissing = new Dictionary<string, int>();
            _counterPresent = new Dictionary<string, int>();
        }

        /// <summary>
        /// Counts the number of topics.
        /// </summary>
        /// <returns>List(int)</returns>
        private List<int> CountTopics()
        {
            Dictionary<string, int> topicsCounter = new Dictionary<string, int>();

            foreach (Document doc in _inputDocs)
            {
                if (topicsCounter.ContainsKey(doc.Topic))
                    topicsCounter[doc.Topic]++;
                else topicsCounter[doc.Topic] = 1;
            }
            return topicsCounter.Values.ToList();
        }


        /// <summary>
        /// Filter attributes for a given global and document vectors
        /// based on information gain
        /// </summary>
        /// <param name="globalVector"></param>
        /// <param name="documents"></param>
        public void FilterAttributes(List<string> globalVector, List<Document> documents)
        {
            _inputGlobalVector = globalVector;
            _inputDocs = documents;
            _sampleSize = _inputDocs.Count;

            _documentSetWeights = CountTopics();
            _wholeEntropy = ComputeEntropy(_documentSetWeights);
            List<string> toDiscard = new List<string>();
            foreach (string attrib in _inputGlobalVector)
            {
                double infoGain = ComputeInformationGain(attrib);
                if (infoGain < _threshold)
                {
                    toDiscard.Add(attrib);
                    int attribIndex = _inputGlobalVector.IndexOf(attrib);
                    foreach (Document doc in documents)
                    {
                        bool valueExists = doc.FrequencyVector.Any(kv => kv.Value == attribIndex);
                        if (valueExists)
                            doc.FrequencyVector.Remove(attribIndex);
                    }
                }
            }

            foreach (string attrib in toDiscard)
                _inputGlobalVector.Remove(attrib);

            globalVector = _inputGlobalVector;
        }

        /// <summary>
        /// Computes the entropy based on a given set.
        /// </summary>
        /// <param name="set"></param>
        /// <returns>double entropyValue</returns>
        private double ComputeEntropy(IEnumerable<int> set)
        {

            double entropyValue = 0;

            foreach (int attrib in set)
            {
                double probability = (double)attrib / _sampleSize;
                if (probability > 0)
                    entropyValue -= probability * Math.Log(probability) * 1.4426950408889634;
            }

            return entropyValue;
        }

        /// <summary>
        /// Computes information gain for the given attribute.
        /// </summary>
        /// <param name="attribute"></param>
        /// <returns>double infoGain</returns>
        private double ComputeInformationGain(string attribute)
        {

            _counterMissing.Clear();
            _counterPresent.Clear();

            double infoGain = 0;
            double entropyPresent = 0;
            double entropyMissing = 0;

            int attribIndex = _inputGlobalVector.IndexOf(attribute);

            foreach (Document doc in _inputDocs)
            {

                if (doc.FrequencyVector.ContainsKey(attribIndex))
                {
                    if (!_counterPresent.ContainsKey(doc.Topic))
                        _counterPresent[doc.Topic] = 0;
                    _counterPresent[doc.Topic]++;
                }
                else
                {
                    if (!_counterMissing.ContainsKey(doc.Topic))
                        _counterMissing[doc.Topic] = 0;
                    _counterMissing[doc.Topic]++;
                }
            }

            entropyPresent = ComputeEntropy(_counterPresent.Values);
            entropyMissing = ComputeEntropy(_counterMissing.Values);

            double sumPresent = _counterPresent.Values.Sum();
            double sumMissing = _counterMissing.Values.Sum();
            double weightPresent = (double)sumPresent / _sampleSize;
            double weightMissing = (double)sumMissing / _sampleSize;
            infoGain = _wholeEntropy - weightPresent * entropyPresent - weightMissing * entropyMissing;

            return infoGain;
        }
    }
}
