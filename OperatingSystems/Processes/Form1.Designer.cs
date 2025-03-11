namespace Processes
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
            notepadButton = new Button();
            paintButton = new Button();
            openFileButton = new Button();
            closeFileButton = new Button();
            SuspendLayout();
            // 
            // notepadButton
            // 
            notepadButton.Location = new Point(46, 54);
            notepadButton.Name = "notepadButton";
            notepadButton.Size = new Size(128, 50);
            notepadButton.TabIndex = 0;
            notepadButton.Text = "Notepad";
            notepadButton.UseVisualStyleBackColor = true;
            notepadButton.Click += button1_Click;
            // 
            // paintButton
            // 
            paintButton.Location = new Point(419, 54);
            paintButton.Name = "paintButton";
            paintButton.Size = new Size(94, 29);
            paintButton.TabIndex = 1;
            paintButton.Text = "Paint";
            paintButton.UseVisualStyleBackColor = true;
            // 
            // openFileButton
            // 
            openFileButton.Location = new Point(46, 259);
            openFileButton.Name = "openFileButton";
            openFileButton.Size = new Size(94, 29);
            openFileButton.TabIndex = 2;
            openFileButton.Text = "Open file";
            openFileButton.UseVisualStyleBackColor = true;
            openFileButton.Click += button3_Click;
            // 
            // closeFileButton
            // 
            closeFileButton.Location = new Point(435, 259);
            closeFileButton.Name = "closeFileButton";
            closeFileButton.Size = new Size(94, 29);
            closeFileButton.TabIndex = 3;
            closeFileButton.Text = "Close file";
            closeFileButton.UseVisualStyleBackColor = true;
            closeFileButton.Click += closeFileButton_Click;
            // 
            // Form1
            // 
            AutoScaleDimensions = new SizeF(8F, 20F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(800, 450);
            Controls.Add(closeFileButton);
            Controls.Add(openFileButton);
            Controls.Add(paintButton);
            Controls.Add(notepadButton);
            Name = "Form1";
            Text = "Form1";
            ResumeLayout(false);
        }

        #endregion

        private Button notepadButton;
        private Button paintButton;
        private Button openFileButton;
        private Button closeFileButton;
    }
}
