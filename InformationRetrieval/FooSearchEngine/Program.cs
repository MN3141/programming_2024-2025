using System;
using FooSearchEngine.Classes;

namespace MyApp
{
    internal class Program
    {
        static void Main(string[] args)
        {
            // REMOVE tabs and mathematical signs
            // update output file structure
            // check how Windows API could be used to add multithreading
            string appDir = Path.GetFullPath(AppContext.BaseDirectory + "..\\..\\..");
            string inputDir = Path.GetFullPath(appDir + "\\..\\Reuters_7083");

            XMLSearchEngine google = new XMLSearchEngine(inputDir);
            google.Search();
        }
    }
}