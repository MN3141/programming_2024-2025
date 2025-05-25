using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FooSearchEngine.Interfaces;

namespace FooSearchEngine.Classes
{
    class VectorNormalizer : IVectorNormalizer
    {
        private List<Document> _docs;

        public VectorNormalizer() {
            this._docs = new List<Document>();
        }
        public List<Document> GetDocuments()
        {
            return this._docs;
        }

        public void NormalizeVectors()
        {
            foreach (Document doc in this._docs)
                NormalizeFunction(doc.FrequencyVector);
        }
        private void NormalizeFunction(Dictionary<int, float> freqVector) {

            for (int i = 0; i < freqVector.Count; i++)
            {
                freqVector[i] = (float)(1 + Math.Log(1 + Math.Log(freqVector[i])));
            }
        }
    }
}
