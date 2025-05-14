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
        /// Parse all of the given XML files for attributes.
        /// </summary>
        /// <param name="inputFilesPaths"></param>
        /// <returns>
        /// Returns a list of parsed documents with updated frequency and global vectors.
        /// </returns>
        public List<Document> ParseDocuments(string[] inputFilesPaths, List<string> globalVector);
    }
}
