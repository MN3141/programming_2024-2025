using System.Diagnostics;
using WinAPI = WinApiClass.WinApiClass;
  

namespace ThreadManager
{
    public partial class Form1 : Form
    {
        private uint outBuffer = 0;
        private uint _threadHandler0, _threadHandler1 , _threadHandler2;
        private uint IncrementProgressBar0(IntPtr arg) // this is the form that WinAPI accepts
        {
            int i = 0;
            while(i <= this.progressBar0.Maximum)
            {
                this.progressBar0.PerformStep();
                i++;
            }
            return 0;
        }

        private uint IncrementProgressBar1(IntPtr arg)
        {
            int i = 0;
            while (i <= this.progressBar1.Maximum)
            {
                this.progressBar1.PerformStep();
                i++;
            }
            return 0;
        }

        private uint IncrementProgressBar2(IntPtr arg)
        {
            int i = 0;
            while (i <= this.progressBar2.Maximum)
            {
                this.progressBar2.PerformStep();
                i++;
            }
            return 0;
        }

        public Form1()
        {
            InitializeComponent();
            CheckForIllegalCrossThreadCalls = false; // Allow other thread to access memory from each other
            this._threadHandler0 = WinAPI.CreateThread(IntPtr.Zero, 0, this.IncrementProgressBar0, IntPtr.Zero, 0, out outBuffer);
            this._threadHandler1 = WinAPI.CreateThread(IntPtr.Zero, 0, this.IncrementProgressBar1, IntPtr.Zero, 0, out outBuffer);
            this._threadHandler2 = WinAPI.CreateThread(IntPtr.Zero, 0, this.IncrementProgressBar2, IntPtr.Zero, 0, out outBuffer);
        }

        private void processButton0_Click(object sender, EventArgs e)
        {
            Debug.Print("Thread 0 ");
            if (this.threadButton0.Text == "Suspend")
            {
                WinAPI.SuspendThread((nint)this._threadHandler0);
                this.threadButton0.Text = "Resume";
        
            }
            else
            {
                this.threadButton0.Text = "Suspend";
                this._threadHandler0 = WinAPI.ResumeThread((nint)this._threadHandler0);
                Debug.Print("RESUME");
            }

            
            
        }

        private void processButton1_Click(object sender, EventArgs e)
        {
            Debug.Print("Thread 1 ");
            if (this.threadButton1.Text == "Suspend")
            {
                WinAPI.SuspendThread((nint)this._threadHandler1);
                this.threadButton1.Text = "Resume";

            }
            else
            {
                this.threadButton1.Text = "Suspend";
                this._threadHandler1 = WinAPI.ResumeThread((nint)this._threadHandler1);
                Debug.Print("RESUME");
            }
        }

        private void processButton2_Click(object sender, EventArgs e)
        {
            Debug.Print("Thread 2 ");
            if (this.threadButton2.Text == "Suspend")
            {
                WinAPI.SuspendThread((nint)this._threadHandler2);
                this.threadButton2.Text = "Resume";

            }
            else
            {
                this.threadButton2.Text = "Suspend";
                this._threadHandler2 = WinAPI.ResumeThread((nint)this._threadHandler2);
                Debug.Print("RESUME");
            }
        }
    }
}
