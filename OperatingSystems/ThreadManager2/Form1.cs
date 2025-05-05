using WinAPI = WinApiClass.WinApiClass;

namespace ThreadManager2
{
    public partial class Form1 : Form
    {
        Dictionary<string, uint> threadsMap;
        private uint _outBuffer = 0;
        public Form1()
        {
            InitializeComponent();
            this.threadsMap = new Dictionary<string, uint>();
            CheckForIllegalCrossThreadCalls = false;

            uint _thread0 = WinAPI.CreateThread(IntPtr.Zero, 0, this.IncrementProgressBar, this.threadProgressBar0.Handle, 0, out _outBuffer);
            uint _thread1 = WinAPI.CreateThread(IntPtr.Zero, 0, this.IncrementProgressBar, this.threadProgressBar1.Handle, 0, out _outBuffer);
            uint _thread2 = WinAPI.CreateThread(IntPtr.Zero, 0, this.IncrementProgressBar, this.threadProgressBar2.Handle, 0, out _outBuffer);

            this.threadsMap.Add(this.threadSuspendBtn0.Name, _thread0);
            this.threadsMap.Add(this.threadSuspendBtn1.Name, _thread1);
            this.threadsMap.Add(this.threadSuspendBtn2.Name, _thread2);

        }

        private uint IncrementProgressBar(IntPtr param)
        {
            ProgressBar progressBar = null;

            if (param == this.threadProgressBar0.Handle)
                progressBar = this.threadProgressBar0;

            if (progressBar != null)
            {
                int i = 0;
                while (i <= progressBar.Maximum)
                {
                    progressBar.PerformStep();
                    i++;
                }
                return 0;
            }

            else return 1;
        }

        private void CheckButtonText(ref Button button)
        {
            if (button.Text == "SUSPEND")
                button.Text = "RESUME";
            else button.Text = "SUSPEND";
        }
        private void threadSuspendBtn0_Click(object sender, EventArgs e)
        {
            Button btn0 = (Button)sender;
            MessageBox.Show(btn0.Name);

        }

        private void threadSuspendBtn1_Click(object sender, EventArgs e)
        {

        }

        private void threadSuspendBtn2_Click(object sender, EventArgs e)
        {

        }

        private void threadTimeInfoBtn0_Click(object sender, EventArgs e)
        {

        }

        private void threadTimeInfoBtn1_Click(object sender, EventArgs e)
        {

        }

        private void threadTimeInfoBtn2_Click(object sender, EventArgs e)
        {

        }
    }
}
