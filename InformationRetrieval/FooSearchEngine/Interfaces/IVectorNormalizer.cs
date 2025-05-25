using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection.Metadata;
using System.Text;
using System.Threading.Tasks;

namespace FooSearchEngine.Interfaces
{
    interface IVectorNormalizer
    {
        public void NormalizeVectors();
        public List<Document> GetDocuments();
    }
}
