using System;
using System.Collections.Generic;
class Document
{
     string _fileName, _title;
     string _outputFileName;
     List<String> _globalVector;
    List<Dictionary<int, int>> _frequencyVector;

    public Document(string fileName)
    {
        this._fileName = fileName;
        this._globalVector = new List<string>();
        this._frequencyVector = new List<Dictionary<int, int>>();
    }

    public void SetDocumentTitle(string title)
    {
        this._title = title;
    }
    public void SetOutputFileName(string fileName)
    {
        this._outputFileName = fileName;
    }

    public string GetFileName()
    {
        return this._fileName;
    }

}