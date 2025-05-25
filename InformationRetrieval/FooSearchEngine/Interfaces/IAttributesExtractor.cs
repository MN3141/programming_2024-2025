using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection.Metadata;
using System.Text;
using System.Threading.Tasks;
using Document = FooSearchEngine.Classes.Document;

namespace FooSearchEngine.Interfaces
{
    /// <summary>
    /// Interface used to define extracting attributes behaviour
    /// </summary>
    ///
    public interface IAttributesExtractor
    {
        /// <summary>
        /// Parse the given data into Document format and builds a
        /// global vector based on it.
        /// </summary>
        /// <returns>
        /// void
        /// </returns>
        public void ParseData();
        public List<Document> GetDocuments();
        public List<string> GetGlobalVector();
    }
}
