namespace ThreadInfo
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
            processInfoTextBox = new TextBox();
            threadInfoTextbox = new TextBox();
            processInfoLabel = new Label();
            threadInfoLabel = new Label();
            SuspendLayout();
            // 
            // processInfoTextBox
            // 
            processInfoTextBox.Location = new Point(111, 218);
            processInfoTextBox.Name = "processInfoTextBox";
            processInfoTextBox.Size = new Size(125, 27);
            processInfoTextBox.TabIndex = 0;
            // 
            // threadInfoTextbox
            // 
            threadInfoTextbox.Location = new Point(464, 218);
            threadInfoTextbox.Name = "threadInfoTextbox";
            threadInfoTextbox.Size = new Size(125, 27);
            threadInfoTextbox.TabIndex = 1;
            // 
            // processInfoLabel
            // 
            processInfoLabel.AutoSize = true;
            processInfoLabel.Location = new Point(111, 85);
            processInfoLabel.Name = "processInfoLabel";
            processInfoLabel.Size = new Size(84, 20);
            processInfoLabel.TabIndex = 2;
            processInfoLabel.Text = "ProcessInfo";
            // 
            // threadInfoLabel
            // 
            threadInfoLabel.AutoSize = true;
            threadInfoLabel.Location = new Point(486, 85);
            threadInfoLabel.Name = "threadInfoLabel";
            threadInfoLabel.Size = new Size(87, 20);
            threadInfoLabel.TabIndex = 3;
            threadInfoLabel.Text = "ThreadsInfo";
            // 
            // Form1
            // 
            AutoScaleDimensions = new SizeF(8F, 20F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(800, 450);
            Controls.Add(threadInfoLabel);
            Controls.Add(processInfoLabel);
            Controls.Add(threadInfoTextbox);
            Controls.Add(processInfoTextBox);
            Name = "Form1";
            Text = "Form1";
            Load += Form1_Load;
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private TextBox processInfoTextBox;
        private TextBox threadInfoTextbox;
        private Label processInfoLabel;
        private Label threadInfoLabel;
    }
}
