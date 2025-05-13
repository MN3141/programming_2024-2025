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
        string[] _labels;

        public AttributesPreprocessor(){

            this._threshold = 0.5f;
        }

        /// <summary>
        /// Filter attributes for a given global and document vectors
        /// based on information gain
        /// </summary>
        /// <param name="globalVector"></param>
        /// <param name="documents"></param>
        public void FilterAttributes(List<string> globalVector, List<Document> documents)
        {

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
