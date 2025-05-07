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
        readonly string _fileName;
        string _title;
        Dictionary<int, int> _frequencyVector;

        /// <summary>
        /// fileName represents the
        /// absolute file path.
        /// </summary>
        /// <param name="fileName"></param>
        public Document(string fileName)
        {
            this._fileName = fileName;
            this._title = "FOO";
            this._frequencyVector = new Dictionary<int, int>();
        }

        /// <summary>
        /// Sets the title of the document.
        /// </summary>
        /// <param name="title"></param>
        public void SetDocumentTitle(string title)
        {
            this._title = title;
        }
        /// <summary>
        /// Returns the name of the file.
        /// </summary>
        /// <returns>string</returns>
        public string GetFileName()
        {
            return this._fileName;
        }

        /// <summary>
        ///Returns the frequency vector.
        /// </summary>
        /// <returns>Dictionary</returns>
        public Dictionary<int, int> GetFrequencyVector()
        {
            return this._frequencyVector;
        }

        /// <summary>
        /// Adds a new entry in frequency vector.
        /// </summary>
        /// <param name="wordIndex"></param>
        public void AddNewEntry(int wordIndex)
        {
            this._frequencyVector.Add(wordIndex, 1);
        }

        /// <summary>
        /// Check if the document contains a word given by the index.
        /// </summary>
        /// <param name="wordIndex"></param>
        public void CheckWordFrequencyVector(int wordIndex)
        {

            if (this._frequencyVector.ContainsKey(wordIndex))
                this._frequencyVector[wordIndex] += 1;
        }

    }
}
