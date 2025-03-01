using System;
using System.IO;
public class DocumentVector
{

    private string FilePath;
    private string[] DocumentString;

    public DocumentVector(string filePath)
    {
        this.FilePath = filePath;
        try
        {
            this.DocumentString = File.ReadAllLines(this.FilePath);
        }
        catch (Exception ex)
        {
            Console.WriteLine("An error occurred: " + ex.Message);
        }
    }

    public string GetFileName()
    {

        string[] files = this.FilePath.Split('\\');
        int filesNum = files.Length;
        return files[filesNum - 1];
    }
}
