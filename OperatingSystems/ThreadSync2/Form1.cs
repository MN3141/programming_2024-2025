using System;
using System.Linq.Expressions;
using System.Threading;
using System.Windows.Forms.VisualStyles;
using WinAPI = WinApiClass.WinApiClass;

namespace ThreadSync2
{
    public partial class Form1 : Form
    {
        private uint _outBuffer = 0;
        private int counter;
        Dictionary<string, uint> threadsMap;
        Dictionary<string, nint> eventsMap;

        public Form1()
        {
            InitializeComponent();
            CheckForIllegalCrossThreadCalls = false;
            this.threadsMap = new Dictionary<string, uint>();
            this.eventsMap = new Dictionary<string, nint>();
            this.counter = 0;

        }

        private uint IncrementProgressBar(IntPtr param)
        {
            ProgressBar progressBar = null;
            nint currentEvent = -1;
            nint previousEvent = -1;
            uint eventResult = 1234;

            if (param == this.mariaBar.Handle)
            {
                progressBar = this.mariaBar;
                currentEvent = this.eventsMap["Maria Event"];

            }
            else if (param == this.cosminBar.Handle)
            {
                progressBar = this.cosminBar;
                currentEvent = this.eventsMap["Cosmin Event"];
                previousEvent = this.eventsMap["Maria Event"];
            }
                
            else if (param == this.laviniaBar.Handle)
            {
                progressBar = laviniaBar;
                currentEvent = this.eventsMap["Lavinia Event"];
                previousEvent = this.eventsMap["Cosmin Event"];
            }

            if(previousEvent != -1)
            {
                //it's not Maria's event
                eventResult = WinAPI.WaitForSingleObject(previousEvent, uint.MaxValue);
            }

            if (progressBar != null)
            {
                int i = 0;
                while (i <= progressBar.Maximum)
                {
                    progressBar.PerformStep();
                    i++;
                }
                WinAPI.SetEvent(currentEvent);
                return 0;
            }

            else return 1;
        }
        private void startBtn_Click(object sender, EventArgs e)
        {

            if (this.counter == 0)
            {
                this.eventsMap.Add("Maria Event", WinAPI.CreateEvent(IntPtr.Zero, false, false, "Maria Event"));
                this.eventsMap.Add("Cosmin Event", WinAPI.CreateEvent(IntPtr.Zero, false, false, "Cosmin Event"));
                this.eventsMap.Add("Lavinia Event", WinAPI.CreateEvent(IntPtr.Zero, false, false, "Lavinia Event"));

                uint fooThread = WinAPI.CreateThread(IntPtr.Zero, 0, this.IncrementProgressBar, this.mariaBar.Handle, 0, out _outBuffer);
                this.threadsMap.Add("Maria", fooThread);

                fooThread = WinAPI.CreateThread(IntPtr.Zero, 0, this.IncrementProgressBar, this.cosminBar.Handle, 0, out _outBuffer);
                this.threadsMap.Add("Cosmin", fooThread);

                fooThread = WinAPI.CreateThread(IntPtr.Zero, 0, this.IncrementProgressBar, this.laviniaBar.Handle, 0, out _outBuffer);
                this.threadsMap.Add("Lavinia", fooThread);

                this.counter++;
            }

        }
    }
}
