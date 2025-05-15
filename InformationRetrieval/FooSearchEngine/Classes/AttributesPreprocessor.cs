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
        float _threshold;
        public List<Document> _inputDocs { get; set; }
        public List<string> _inputGlobalVector { get; set; }
        public Dictionary<string,AttributeCounter> _attributeCount { get; set; }

        public AttributesPreprocessor(){

            this._threshold = 0.5f;
            this._inputDocs = new List<Document>();
            this._inputGlobalVector = new List<string>();
            this._attributeCount = new Dictionary<string, AttributeCounter>();
        }

        /// <summary>
        /// Determine where the attributes (do not) appear
        /// in the given document set.
        /// </summary>
        private void ComputeAttributeCounters()
        {
            foreach (string attrib in this._inputGlobalVector){
                foreach(Document doc in this._inputDocs){
                    int attributeIndex = this._inputGlobalVector.IndexOf(attrib);
                    if (doc.FrequencyVector.ContainsKey(attributeIndex)){
                        //this._attributeCount.Add(attrib,)
                    }
                }
            }

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
        }

        private float ComputeEntropy(){

            double log2 = Math.Log(2) * 1.4426950408889634;
            return 0;
        }

        private float ComputeInformationGain(){
            return 0;
        }
    }
}
