using System;
using System.Collections.Generic;
class Document
{
     string _fileName, _title;
     string _outputFileName;
     Dictionary<int, int> _frequencyVector;

    public Document(string fileName)
    {
        this._fileName = fileName;
        this._frequencyVector = new Dictionary<int, int>();
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

    public string GetDocumentTitle()
    {
        return this._title;
    }

    public string GetDocumentOutputFile()
    {
        return this._outputFileName;
    }
    public Dictionary<int, int> GetFrequencyVector()
    {
        return this._frequencyVector;
    }
    public void AddNewEntry(int wordIndex)
    {
        this._frequencyVector.Add(wordIndex, 0);
    }
    public void CheckWordFrequencyVector(int wordIndex)
    {

        if (this._frequencyVector.ContainsKey(wordIndex))
            this._frequencyVector[wordIndex] += 1;

    }

}