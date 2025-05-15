using FooSearchEngine.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FooSearchEngine.Classes
{
    class AttributesPreprocessor: IAttributesPreprocessor
    {
        private double _threshold;
        private int _sampleSize;
        private double _wholeEntropy;
        private List<int> _documentSetWeights;
        public List<Document> _inputDocs { get; set; }
        public List<string> _inputGlobalVector { get; set; }

        public AttributesPreprocessor()
        {

            this._threshold = 0.5f;
            this._inputDocs = new List<Document>();
            this._inputGlobalVector = new List<string>();
            this._documentSetWeights = new List<int>();
        }

        /// <summary>
        /// Counts the number of topics.
        /// </summary>
        /// <returns>List(int)</returns>
        private List<int> CountTopics()
        {
            Dictionary<string, int> topicsCounter = new Dictionary<string, int>();

            foreach (Document doc in this._inputDocs)
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
            this._inputGlobalVector = globalVector;
            this._inputDocs = documents;
            this._sampleSize = this._inputDocs.Count;

            this._documentSetWeights = this.CountTopics();
            this._wholeEntropy = this.ComputeEntropy(this._documentSetWeights);

            foreach (string attrib in this._inputGlobalVector)
            {
                double infoGain = this.ComputeInformationGain(attrib);
                //Console.WriteLine(attrib + " "+infoGain);
            }
        }

        /// <summary>
        /// Computes the entropy based on a given set.
        /// </summary>
        /// <param name="set"></param>
        /// <returns>double entropyValue</returns>
        private double ComputeEntropy(List<int> set)
        {

            double entropyValue = 0;

            for (int i = 0; i < set.Count; i++)
            {
                double probability = (double)set[i] / this._sampleSize;
                entropyValue -= (probability * Math.Log(probability) * 1.4426950408889634);
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

            Dictionary<string, int> counterPresent = new Dictionary<string, int>();
            Dictionary<string, int> counterMissing = new Dictionary<string, int>();
            double infoGain = 0;
            double entropyPresent = 0;
            double entropyMissing = 0;

            foreach (Document doc in this._inputDocs)
            {
                int attribIndex = this._inputGlobalVector.IndexOf(attribute);

                if (doc.FrequencyVector.ContainsKey(attribIndex))
                {
                    if (!counterPresent.ContainsKey(doc.Topic))
                        counterPresent[doc.Topic] = 0;
                    counterPresent[doc.Topic]++;
                }
                else
                {
                    if (!counterMissing.ContainsKey(doc.Topic))
                        counterMissing[doc.Topic] = 0;
                    counterMissing[doc.Topic]++;
                }
            }

            entropyPresent = this.ComputeEntropy(counterPresent.Values.ToList());
            entropyMissing = this.ComputeEntropy(counterMissing.Values.ToList());

            infoGain = this._wholeEntropy - (counterPresent.Values.Sum() / this._sampleSize) * entropyPresent
                     - (counterMissing.Values.Sum() / this._sampleSize) * entropyMissing;

            return infoGain;
        }
    }
}
