using System.Runtime.InteropServices;
using WinAPI = WinApiClass.WinApiClass;

int counter = 0;
int bound = 100;
uint outBuffer = 0;
uint exitCode = 2;

WinAPI.CRITICAL_SECTION mySection;

uint Increment(IntPtr param)
{
    while(counter < bound)
    {
        //Console.WriteLine(counter);
        WinAPI.EnterCriticalSection(ref mySection);
        counter++;
        Console.WriteLine(counter);
        WinAPI.LeaveCriticalSection(ref mySection);
        
    }

    return 0;
}

WinAPI.InitializeCriticalSection(out mySection);

uint threadHandler0 = WinAPI.CreateThread(IntPtr.Zero, 0, Increment, IntPtr.Zero, 0, out outBuffer);
uint threadHandler1 = WinAPI.CreateThread(IntPtr.Zero, 0, Increment, IntPtr.Zero, 0, out outBuffer);

WinAPI.GetExitCodeThread(threadHandler0, out exitCode);

while(exitCode == 259)
{
    WinAPI.GetExitCodeThread(threadHandler0, out exitCode);
    //Console.WriteLine($"Thread0:",exitCode);
}

WinAPI.GetExitCodeThread(threadHandler1, out exitCode);

while (exitCode == 259)
{
    WinAPI.GetExitCodeThread(threadHandler1, out exitCode);
    //Console.WriteLine($"Thread1:", exitCode);
}

Console.WriteLine("Job done");
//if (exitCode != 0)
//{
    
//    WinAPI.GetExitCodeThread(threadHandler1, out exitCode);
//    if (exitCode != 0)
//        Console.WriteLine("WAITING");
        
//}
WinAPI.DeleteCriticalSection(ref mySection);
