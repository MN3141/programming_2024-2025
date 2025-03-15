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

    public string GetDocumentTitle()
    {
        return this._title;
    }

    public string GetDocumentOutputFile()
    {
        return this._outputFileName;
    }

    public List<String> GetGlobalVector()
    {
        return this._globalVector;
    }

    public List< Dictionary<int,int> > GetFrequencyVector()
    {
        return this._frequencyVector;
    }

    public void CheckWordGlobalVector(string word)
    {
        if (this._globalVector.Contains(word))
            this._globalVector.Add(word);
    }

    public void CheckWordFrequencyVector(string word)
    {
        int wordIndex = this._globalVector.IndexOf(word);

        if (wordIndex != -1)
        {
            foreach (Dictionary<int, int> dic in this._frequencyVector)
            {
                if (dic.ContainsKey(wordIndex))
                    dic[wordIndex] = dic[wordIndex] + 1;
                else dic[wordIndex] = 1;
            }
        }
    }
}