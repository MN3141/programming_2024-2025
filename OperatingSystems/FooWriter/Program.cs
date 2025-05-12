using System.Diagnostics;
using System.Text;
using WinAPI = WinApiClass.WinApiClass;

namespace Foo
{
    internal static class Program
    {

        static void Main()
        {

            WinAPI.OpenMutex(0x001f001, false, "FooMutex");
            string fileName = "C:\\Arhiva_ULBS\\Proiecte\\Anul_III\\programming_2024-2025\\OperatingSystems\\Mutex\\foo.txt";
            IntPtr fileHandle = WinAPI.CreateFile(
             fileName,
             WinAPI.FileAccess.FILE_WRITE_DATA,        // Open for reading and writing
             WinAPI.FileShare.None,              // Do not allow sharing
             IntPtr.Zero,                 // No security attributes
             WinAPI.FileMode.OPEN_EXISTING,             // Open existing
             WinAPI.FileAttributes.Normal,        // Normal file attributes
             IntPtr.Zero);

            byte[] msg = Encoding.UTF8.GetBytes("IPRS BALGRAD. Mikro Avtamat OGAS Spejalni. 1453-2003");
            uint bytesToWrite = (uint)msg.Length;
            uint bufferSize = bytesToWrite;
            if (!WinAPI.WriteFile(fileHandle, msg, bufferSize, out bytesToWrite, IntPtr.Zero))
                throw new Exception("Cannot write to given file!");

        }
    }
}