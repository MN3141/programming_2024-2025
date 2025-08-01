using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FooSearchEngine.Interfaces;

namespace FooSearchEngine.Classes
{
    public class VectorNormalizer : IVectorNormalizer
    {
        private List<Document> _docs;
        private List<string> _globalVector;

        public VectorNormalizer()
        {
            _globalVector = new List<string>();
            _docs = new List<Document>();
        }
        public List<Document> GetDocuments()
        {
            return _docs;
        }

        /// <summary>
        /// Normalizes the given vector by
        /// computing the frequency and getting the
        /// frequency vector at the same lenght as
        /// the global one.
        /// </summary>
        public void NormalizeVectors(List<string> globalVector, List<Document> docs)
        {
            _globalVector = globalVector;
            _docs = docs;
            Dictionary<string, int> attributeIndexMap = new Dictionary<string, int>();
            for (int i = 0; i < _globalVector.Count; i++)
            {
                attributeIndexMap[_globalVector[i]] = i;
            }
            foreach (Document doc in _docs)
                NormalizeFunction(doc.FrequencyVector,attributeIndexMap);
        }
        private void NormalizeFunction(Dictionary<int, float> freqVector, Dictionary<string, int> attributeIndexMap) {

            foreach (var pair in attributeIndexMap)
                {
                    int wordIndex = pair.Value;

                    if (freqVector.ContainsKey(wordIndex))
                        freqVector[wordIndex] = 1;
                    else
                        freqVector[wordIndex] = 0;
                }
        }
    }
}
