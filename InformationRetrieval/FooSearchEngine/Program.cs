using System;
using FooSearchEngine.Classes;

namespace MyApp
{
    internal class Program
    {
        static void Main(string[] args)
        {
            // check how Windows API could be used to add multithreading
            // Update logic for extracting files so that we can use it
            // for queries
            string appDir = Path.GetFullPath(AppContext.BaseDirectory + "..\\..\\..");
            //string inputDir = Path.GetFullPath(appDir + "\\..\\Reuters_34\\Training");
            string inputDir = Path.GetFullPath(appDir + "\\..\\Reuters_7083");

            XMLSearchEngine google = new XMLSearchEngine(inputDir);
            string queriesFile = Path.GetFullPath(appDir + "\\Utils\\interogari.txt");
            foreach (string line in File.ReadLines(queriesFile))
            {
                Console.WriteLine(line);
                google.Search(line);
                Console.WriteLine("==================================");
            }
        }
    }
}