using System;
class Program
{
    static void Main()
    {
        string[] filesPaths = new string[] {
            "..\\docs\\d1.txt",
            "..\\docs\\d2.txt",
            "..\\docs\\d3.txt"
        };
        int filesNum = filesPaths.Length;
        DocumentVector[] docVectors = new DocumentVector[filesNum];
        for (int i=0; i<filesNum;i++){
            docVectors[i]=new DocumentVector(filesPaths[i]);
            Console.WriteLine(docVectors[i].GetFileName());
        }
    }
}
