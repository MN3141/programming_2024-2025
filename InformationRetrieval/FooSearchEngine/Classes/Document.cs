using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FooSearchEngine.Classes
{
    /// <summary>
    ///  Represents a document used by search engine.
    /// </summary>
    public class Document
    {
        public string FileName { get; set; }
        public string Title { get; set; }
        public string Topic { get; set; }
        public Dictionary<int, float> FrequencyVector { get; set; }

        /// <summary>
        /// fileName represents the
        /// absolute file path.
        /// </summary>
        /// <param name="fileName"></param>
        public Document(string fileName)
        {
            FileName = fileName;
            Title = "FOO";
            Topic = "FOO topic";
            FrequencyVector = new Dictionary<int, float>();
        }
        public Document()
        {
            FileName = "Foo";
            Title = "FOO";
            Topic = "FOO topic";
            FrequencyVector = new Dictionary<int, float>();
        }
        /// <summary>
        /// Adds a new entry in frequency vector.
        /// </summary>
        /// <param name="wordIndex"></param>
        public void AddNewEntry(int wordIndex)
        {
            FrequencyVector.Add(wordIndex, 1);
        }

        /// <summary>
        /// Check if the document contains a word given by the index.
        /// </summary>
        /// <param name="wordIndex"></param>
        public void CheckWordFrequencyVector(int wordIndex)
        {

            if (FrequencyVector.ContainsKey(wordIndex))
                FrequencyVector[wordIndex] += 1;
        }

    }
}
