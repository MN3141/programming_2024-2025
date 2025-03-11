using System.Diagnostics;
using static WinApiClass.WinApiClass;
using WinAPI = WinApiClass.WinApiClass;

namespace Processes
{
    public partial class Form1 : Form
    {
        WinAPI.STARTUPINFO startInfo;
        WinAPI.PROCESS_INFORMATION processInfo;
        WinAPI.SECURITY_ATTRIBUTES threadAttrib;
        WinAPI.SECURITY_ATTRIBUTES processAttrib;
        OpenFileDialog fileDialog;
        Queue<WinAPI.PROCESS_INFORMATION> processes;
        public Form1()
        {
            InitializeComponent();
            threadAttrib = new WinAPI.SECURITY_ATTRIBUTES();
            startInfo = new WinAPI.STARTUPINFO();
            threadAttrib = new WinAPI.SECURITY_ATTRIBUTES();
            processInfo = new WinAPI.PROCESS_INFORMATION();
            fileDialog = new OpenFileDialog();
            this.processes = new Queue<WinAPI.PROCESS_INFORMATION>();

        }

        private void button1_Click(object sender, EventArgs e)
        {
            Debug.Print("Notepad");

            bool success = WinAPI.CreateProcess(
           null, "C:\\Windows\\System32\\notepad.exe", ref processAttrib, ref threadAttrib,
           false, 0, IntPtr.Zero, null, ref startInfo, out processInfo);

            if (!success)
            {
                MessageBox.Show("ERROR!");

            }
            else this.processes.Enqueue(processInfo);
        }

        private void button3_Click(object sender, EventArgs e)
        {

            //Open a file

            this.fileDialog.InitialDirectory = "c:\\";
            if (this.fileDialog.ShowDialog() == DialogResult.OK)
            {
                string fileName = this.fileDialog.FileName;

                bool notepadProcess = WinAPI.CreateProcess(null, "C:\\Windows\\System32\\notepad.exe " + fileName, ref processAttrib, ref threadAttrib,
           false, 0, IntPtr.Zero, null, ref startInfo, out processInfo);

                if (!notepadProcess)
                    MessageBox.Show("ERROR!");
                else
                    this.processes.Enqueue(processInfo);
            }

        }

        private void closeFileButton_Click(object sender, EventArgs e)
        {
            if (this.processes.Count != 0)
            {
                Debug.Print(this.processes.Count.ToString());
                WinAPI.PROCESS_INFORMATION process = this.processes.Dequeue();
                bool terminate = WinAPI.TerminateProcess(process.hProcess, 0);

            }
            else MessageBox.Show("Empty queue!");
        }

        private void paintButton_Click(object sender, EventArgs e)
        {
            bool paintProcess = WinAPI.CreateProcess(null, "C:\\Windows\\System32\\mspaint.exe", ref processAttrib, ref threadAttrib,
           false, 0, IntPtr.Zero, null, ref startInfo, out processInfo);
            if (!paintProcess)
                MessageBox.Show("ERROR!");
        }
    }
}
