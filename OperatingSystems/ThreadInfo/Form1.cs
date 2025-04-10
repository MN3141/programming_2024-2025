using System.Diagnostics;
using System.Runtime.InteropServices;
using static WinApiClass.WinApiClass;
using WinAPI = WinApiClass.WinApiClass;

namespace ThreadInfo
{

    public partial class Form1 : Form
    {
        string _applicationName = "ThreadInfo.exe";
        uint _getProcessesSnap = 0x00000002;
        int _openProcessFlag = 0x1F0FFF;
        WinAPI.PROCESSENTRY32 _processInfo; //structure used for storing process data
        int ACCESS_DENIED_CODE = 5;
        public Form1()
        {
            InitializeComponent();
            this._processInfo = new WinAPI.PROCESSENTRY32();
            this._processInfo.dwSize = (uint)Marshal.SizeOf(typeof(WinAPI.PROCESSENTRY32));
        }

        private void GetProcess()
        {
            IntPtr processSnap = WinAPI.CreateToolhelp32Snapshot(this._getProcessesSnap, 0);

            if (!WinAPI.Process32First(processSnap, ref this._processInfo))
            {
                Debug.Print("Cannot get first process!");
                return;
            }
            else
            {
                while (WinAPI.Process32Next(processSnap, ref this._processInfo))
                {

                    IntPtr processHandle = WinAPI.OpenProcess(this._openProcessFlag, false, (int)this._processInfo.th32ProcessID);
                    int statusCode = WinAPI.GetLastError();

                    if (processHandle == IntPtr.Zero)
                    {
                        Debug.Print("Cannot open process! " + this._processInfo.szExeFile);

                        if (statusCode == this.ACCESS_DENIED_CODE)
                        {
                            Debug.Print("NO ACCESS RIGHTS");
                        }

                    }
                    if (this._processInfo.szExeFile.Equals(this._applicationName, StringComparison.OrdinalIgnoreCase))
                    {
                        MessageBox.Show("YES");
                        return;
                    }
                }
                }
            }
        private void Form1_Load(object sender, EventArgs e)
        {
            this.GetProcess();
        }
    }
}
