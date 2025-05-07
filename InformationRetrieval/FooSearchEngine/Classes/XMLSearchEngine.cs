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
        string _outputDir;
        List<string> _globalVector;
        List<Document> _documents;
        IAttributesExtractor _attributesExtractor;

        /// <summary>
        /// Constructor using files from a given directory
        /// </summary>
        /// <param name="inputFilesDir"></param>
        public XMLSearchEngine(string inputFilesDir)
        {
            this._inputFilesPaths = Directory.GetFiles(inputFilesDir);
            this._globalVector = new List<string>();
            this._outputDir = "output";
            this._documents = new List<Document>();
            this._attributesExtractor = new AttributesExtractor();
        }

        /// <summary>
        /// Constructor using absolute paths for files that can be in different directories
        /// </summary>
        /// <param name="inputFilesPaths"></param>
        public XMLSearchEngine(string[] inputFilesPaths)
        {
            this._inputFilesPaths = inputFilesPaths;
            this._globalVector = new List<string>();
            this._outputDir = "output";
            this._documents = new List<Document>();
            this._attributesExtractor = new AttributesExtractor();
        }

        public void Search()
        {
            this._documents = this._attributesExtractor.ParseDocuments(this._inputFilesPaths, this._globalVector);
        }

        public void SetOutputDir(string dirPath)
        {
            if (!Directory.Exists(dirPath))
            {
                Directory.CreateDirectory(dirPath);
            }

            this._outputDir = dirPath;
        }
    }
}
