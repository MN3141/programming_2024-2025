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
            foreach (Document doc in _docs)
                NormalizeFunction(doc.FrequencyVector);
        }
        private void NormalizeFunction(Dictionary<int, float> freqVector) {

            foreach (string attrib in _globalVector)
            {
                int wordIndex = _globalVector.IndexOf(attrib);

                if (freqVector.ContainsKey(wordIndex))
                    freqVector[wordIndex] = (float)(1 + Math.Log(1 + Math.Log(freqVector[wordIndex])));
                else
                    freqVector.Add(wordIndex, 0);
            }
        }
    }
}
