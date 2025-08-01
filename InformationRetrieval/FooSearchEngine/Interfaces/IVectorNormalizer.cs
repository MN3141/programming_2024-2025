using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection.Metadata;
using System.Text;
using System.Threading.Tasks;
using Document = FooSearchEngine.Classes.Document;

namespace FooSearchEngine.Interfaces
{
    public interface IVectorNormalizer
    {
        public void NormalizeVectors(List<string> globalVector, List<Document> docs);
        public List<Document> GetDocuments();
    }
}
