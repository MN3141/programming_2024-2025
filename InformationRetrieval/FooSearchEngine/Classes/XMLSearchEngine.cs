using FooSearchEngine.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FooSearchEngine.Classes
{
    class XMLSearchEngine
    {
        string[] _inputFilesPaths;
        List<string> _globalVector;
        List<string> _labels;
        List<Document> _documents;
        IAttributesExtractor _attributesExtractor;
        IAttributesPreprocessor _attributesPreprocessor;

        /// <summary>
        /// Constructor using files from a given directory
        /// </summary>
        /// <param name="inputFilesDir"></param>
        public XMLSearchEngine(string inputFilesDir)
        {
            this._inputFilesPaths = Directory.GetFiles(inputFilesDir);
            this._globalVector = new List<string>();
            this._documents = new List<Document>();
            this._attributesExtractor = new XMLExtractor(inputFilesDir);
            this._attributesPreprocessor = new AttributesPreprocessor();
        }

        /// <summary>
        /// Constructor using absolute paths for files that can be in different directories
        /// </summary>
        /// <param name="inputFilesPaths"></param>
        public XMLSearchEngine(string[] inputFilesPaths)
        {
            this._inputFilesPaths = inputFilesPaths;
            this._globalVector = new List<string>();
            this._documents = new List<Document>();
            this._attributesExtractor = new XMLExtractor(inputFilesPaths);
        }

        public void Search()
        {
            this._attributesExtractor.ParseData();
            this._documents = _attributesExtractor.GetDocuments();
            this._globalVector = _attributesExtractor.GetGlobalVector();
            this._attributesPreprocessor.FilterAttributes(this._globalVector, this._documents);
        }

    }
}
