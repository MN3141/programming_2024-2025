namespace lab1
{
    partial class Form1
    {
        /// <summary>
        ///  Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        ///  Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        ///  Required method for Designer support - do not modify
        ///  the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            FileOpenButton = new Button();
            richTextBox1 = new RichTextBox();
            SuspendLayout();
            // 
            // FileOpenButton
            // 
            FileOpenButton.Location = new Point(651, 123);
            FileOpenButton.Name = "FileOpenButton";
            FileOpenButton.Size = new Size(94, 29);
            FileOpenButton.TabIndex = 0;
            FileOpenButton.Text = "Open a file";
            FileOpenButton.UseVisualStyleBackColor = true;
            FileOpenButton.Click += FileOpenButton_Click;
            // 
            // richTextBox1
            // 
            richTextBox1.Location = new Point(112, 48);
            richTextBox1.Name = "richTextBox1";
            richTextBox1.Size = new Size(407, 327);
            richTextBox1.TabIndex = 1;
            richTextBox1.Text = "";
            // 
            // Form1
            // 
            AutoScaleDimensions = new SizeF(8F, 20F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(800, 450);
            Controls.Add(richTextBox1);
            Controls.Add(FileOpenButton);
            Name = "Form1";
            Text = "Form1";
            ResumeLayout(false);
        }

        #endregion

        private Button FileOpenButton;
        private RichTextBox richTextBox1;
    }
}
