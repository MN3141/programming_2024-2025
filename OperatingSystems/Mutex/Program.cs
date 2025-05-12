using System.Diagnostics;
using WinAPI = WinApiClass.WinApiClass;

namespace Foo
{
    internal static class Program
    {

        static void Main()
        {
            string fileName = "C:\\Arhiva_ULBS\\Proiecte\\Anul_III\\programming_2024-2025\\OperatingSystems\\Mutex\\foo.txt";
            IntPtr fileHandle = WinAPI.CreateFile(
             fileName,
             WinAPI.FileAccess.FILE_READ_DATA,        // Open for reading and writing
             WinAPI.FileShare.None,              // Do not allow sharing
             IntPtr.Zero,                 // No security attributes
             WinAPI.FileMode.OPEN_EXISTING,             // Open existing
             WinAPI.FileAttributes.Normal,        // Normal file attributes
             IntPtr.Zero);

            uint bufferSize = 1;
            uint readBytes = 0;
            byte[] fileBuffer = new byte[bufferSize];

            IntPtr mutexHandler = WinAPI.CreateMutex(0, true, "FooMutex");
            if (!WinAPI.ReadFile(fileHandle, fileBuffer, bufferSize, out readBytes, IntPtr.Zero))
                throw new Exception("Cannot read given file!");
            string content = System.Text.Encoding.UTF8.GetString(fileBuffer, 0, (int)readBytes);
            Console.WriteLine(content);

            WinAPI.ReleaseMutex(mutexHandler);
        }
    }
}