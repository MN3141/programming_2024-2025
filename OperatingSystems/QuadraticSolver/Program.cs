using System;
using static System.Runtime.InteropServices.JavaScript.JSType;
using WinAPI = WinApiClass.WinApiClass;

namespace QuadraticSolver
{
    internal class Program
    {
        double a, b, c, x0,x1;
        nint eventHandler = WinAPI.CreateEvent(IntPtr.Zero, false, false, "MyEvent");

        public uint GetInput(IntPtr param)
        {
            Console.WriteLine("A:");
            this.a = int.Parse(Console.ReadLine());

            Console.WriteLine("B:");
            this.b = int.Parse(Console.ReadLine());

            Console.WriteLine("C:");
            this.c = int.Parse(Console.ReadLine());

            WinAPI.SetEvent(this.eventHandler);
            return 0;
        }

        public uint SolveEquation(IntPtr param)
        {
            uint result = WinAPI.WaitForSingleObject(eventHandler, uint.MaxValue);
            this.x0 = (-this.b  + Math.Sqrt(this.b* this.b - 4* this.a* this.c)/2*this.a);
            this.x1 = (-this.b - Math.Sqrt(this.b * this.b - 4 * this.a * this.c) / 2 * this.a);

            return 0;
        }
        static void Main(string[] args)
        {
            Program foo = new Program();
            uint outBuffer = 0; 
            uint threadHandler0 = WinAPI.CreateThread(IntPtr.Zero, 0, foo.GetInput, IntPtr.Zero, 0, out outBuffer);
            uint threadHandler1 = WinAPI.CreateThread(IntPtr.Zero, 0, foo.SolveEquation, IntPtr.Zero, 0, out outBuffer);
            uint threadHandler2 = WinAPI.CreateThread(IntPtr.Zero, 0, foo.SolveEquation, IntPtr.Zero, 0, out outBuffer);

            uint exitCode = 2;
            WinAPI.GetExitCodeThread(threadHandler0, out exitCode);

            while (exitCode == 259)
            {
                WinAPI.GetExitCodeThread(threadHandler0, out exitCode);
                //Console.WriteLine($"Thread0:",exitCode);
            }
        }

    }
}