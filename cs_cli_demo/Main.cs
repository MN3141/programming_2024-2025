//Demo to run a visual application using CLI C#

using System;
using System.Windows.Forms;

namespace MyFirstWindowsFormApp
{
    public class MyForm : Form
    {
        private Button myButton;

        public MyForm()
        {
            // Set up the form
            this.Text = "Hello from";
            this.Width = 300;
            this.Height = 200;

            // Set up the button
            myButton = new Button();
            myButton.Text = "Click Me!";
            myButton.Location = new System.Drawing.Point(100, 70);
            myButton.Click += new EventHandler(MyButton_Click);

            // Add the button to the form
            this.Controls.Add(myButton);
        }

        private void MyButton_Click(object sender, EventArgs e)
        {
            // Show a message box when the button is clicked
            MessageBox.Show("Hello, World!");
        }

        [STAThread]
        public static void Main()
        {
            // Run the form
            Application.EnableVisualStyles();
            Application.Run(new MyForm());
        }
    }
}
