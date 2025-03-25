using System.ComponentModel;
using System.Diagnostics;
using System.Runtime.InteropServices;
using WinAPI = WinApiClass.WinApiClass;

namespace TaskManager
{
    public partial class Form1 : Form
    {
        WinAPI.PROCESSENTRY32 processEntry;
        Dictionary<string, IntPtr> activeProcesses;
        int ACCESS_DENIED_CODE;
        public Form1()
        {
            InitializeComponent();
            processEntry = new WinAPI.PROCESSENTRY32();
            activeProcesses = new Dictionary<string, IntPtr>();
            this.ACCESS_DENIED_CODE = 5;
        }

        private void endTaskBtn_Click(object sender, EventArgs e)
        {
            Debug.Print("Killing process");
            string jobName = this.listBox1.SelectedItem.ToString();
            WinAPI.TerminateProcess(this.activeProcesses[jobName],0);
            this.activeProcesses.Remove(jobName);
            this.updateList();
        }


        private void updateList()
        {
            IntPtr processesSnapshot = WinAPI.CreateToolhelp32Snapshot(0x00000002, 0);
            this.processEntry.dwSize = (uint)Marshal.SizeOf(typeof(WinAPI.PROCESSENTRY32));
            if (processesSnapshot == IntPtr.Zero)
                MessageBox.Show("Cannot get snapshot!");

            if (!WinAPI.Process32First(processesSnapshot, ref this.processEntry))
            {
                MessageBox.Show("Error in getting first process!");
                return;

            }

            while (WinAPI.Process32Next(processesSnapshot, ref this.processEntry))
            {

                IntPtr processHandle = WinAPI.OpenProcess(0x1F0FFF, false, (int)this.processEntry.th32ProcessID);
                int statusCode = WinAPI.GetLastError();
                Debug.Print(statusCode.ToString());
                if (statusCode == this.ACCESS_DENIED_CODE)
                    if (processHandle == IntPtr.Zero)
                        Debug.Print("Cannot open process!");
                    else
                        //0x1F0FFF = PROCESS_ALL_ACCESS
                        if (!this.activeProcesses.ContainsKey(processEntry.szExeFile))
                    {
                        this.activeProcesses.Add(processEntry.szExeFile, processHandle);
                    }
            }

            this.listBox1.DataSource = new BindingList<string>(this.activeProcesses.Keys.ToList());
        }
        private void updateButton_Click(object sender, EventArgs e)
        {
            this.updateList();
        }

        private void listBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}
