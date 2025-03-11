using System;
using System.Diagnostics;
using System.Text;
using WinAPI = WinApiClass.WinApiClass;

namespace lab1
{
    public partial class Form1 : Form
    {
        private OpenFileDialog fileDialog;
        public Form1()
        {
            InitializeComponent();
            fileDialog = new OpenFileDialog();
        }

        private void FileOpenButton_Click(object sender, EventArgs e)
        {
            Debug.WriteLine("Button pressed.");
            this.fileDialog.InitialDirectory = "c:\\";
            if (this.fileDialog.ShowDialog() == DialogResult.OK)
            {
                string fileName = this.fileDialog.FileName;
                IntPtr fileHandle = WinAPI.CreateFile(
                            fileName,
                            WinAPI.FileAccess.FILE_READ_DATA,        // Open for reading and writing
                            WinAPI.FileShare.None,              // Do not allow sharing
                            IntPtr.Zero,                 // No security attributes
                            WinAPI.FileMode.OPEN_EXISTING,             // Open existing
                            WinAPI.FileAttributes.Normal,        // Normal file attributes
                            IntPtr.Zero);

                uint bufferSize = 100;
                uint readBytes = 0;
                byte[] fileBuffer = new byte[bufferSize];;
                if (WinAPI.ReadFile(fileHandle, fileBuffer, bufferSize, out readBytes, IntPtr.Zero))
                {
                    Debug.WriteLine("File read!");
                    richTextBox1.Text = System.Text.Encoding.UTF8.GetString(fileBuffer, 0, fileBuffer.Length);
                }
                else MessageBox.Show("Cannot read file!");
            }
        }
    }
}
