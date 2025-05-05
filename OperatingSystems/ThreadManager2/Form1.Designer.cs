namespace ThreadManager2
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
            threadSuspendBtn0 = new Button();
            threadSuspendBtn1 = new Button();
            threadSuspendBtn2 = new Button();
            threadTimeInfoBtn0 = new Button();
            threadTimeInfoBtn1 = new Button();
            threadTimeInfoBtn2 = new Button();
            threadProgressBar0 = new ProgressBar();
            threadProgressBar1 = new ProgressBar();
            threadProgressBar2 = new ProgressBar();
            SuspendLayout();
            // 
            // threadSuspendBtn0
            // 
            threadSuspendBtn0.Location = new Point(339, 68);
            threadSuspendBtn0.Name = "threadSuspendBtn0";
            threadSuspendBtn0.Size = new Size(94, 29);
            threadSuspendBtn0.TabIndex = 0;
            threadSuspendBtn0.Text = "SUSPEND";
            threadSuspendBtn0.UseVisualStyleBackColor = true;
            threadSuspendBtn0.Click += threadSuspendBtn0_Click;
            // 
            // threadSuspendBtn1
            // 
            threadSuspendBtn1.Location = new Point(339, 138);
            threadSuspendBtn1.Name = "threadSuspendBtn1";
            threadSuspendBtn1.Size = new Size(94, 29);
            threadSuspendBtn1.TabIndex = 1;
            threadSuspendBtn1.Text = "SUSPEND";
            threadSuspendBtn1.UseVisualStyleBackColor = true;
            threadSuspendBtn1.Click += threadSuspendBtn1_Click;
            // 
            // threadSuspendBtn2
            // 
            threadSuspendBtn2.Location = new Point(339, 225);
            threadSuspendBtn2.Name = "threadSuspendBtn2";
            threadSuspendBtn2.Size = new Size(94, 29);
            threadSuspendBtn2.TabIndex = 2;
            threadSuspendBtn2.Text = "SUSPEND";
            threadSuspendBtn2.UseVisualStyleBackColor = true;
            threadSuspendBtn2.Click += threadSuspendBtn2_Click;
            // 
            // threadTimeInfoBtn0
            // 
            threadTimeInfoBtn0.Location = new Point(497, 68);
            threadTimeInfoBtn0.Name = "threadTimeInfoBtn0";
            threadTimeInfoBtn0.Size = new Size(94, 29);
            threadTimeInfoBtn0.TabIndex = 3;
            threadTimeInfoBtn0.Text = "TIMES";
            threadTimeInfoBtn0.UseVisualStyleBackColor = true;
            threadTimeInfoBtn0.Click += threadTimeInfoBtn0_Click;
            // 
            // threadTimeInfoBtn1
            // 
            threadTimeInfoBtn1.Location = new Point(497, 138);
            threadTimeInfoBtn1.Name = "threadTimeInfoBtn1";
            threadTimeInfoBtn1.Size = new Size(94, 29);
            threadTimeInfoBtn1.TabIndex = 4;
            threadTimeInfoBtn1.Text = "TIMES";
            threadTimeInfoBtn1.UseVisualStyleBackColor = true;
            threadTimeInfoBtn1.Click += threadTimeInfoBtn1_Click;
            // 
            // threadTimeInfoBtn2
            // 
            threadTimeInfoBtn2.Location = new Point(497, 225);
            threadTimeInfoBtn2.Name = "threadTimeInfoBtn2";
            threadTimeInfoBtn2.Size = new Size(94, 29);
            threadTimeInfoBtn2.TabIndex = 5;
            threadTimeInfoBtn2.Text = "TIMES";
            threadTimeInfoBtn2.UseVisualStyleBackColor = true;
            threadTimeInfoBtn2.Click += threadTimeInfoBtn2_Click;
            // 
            // threadProgressBar0
            // 
            threadProgressBar0.Location = new Point(60, 68);
            threadProgressBar0.Name = "threadProgressBar0";
            threadProgressBar0.Size = new Size(125, 29);
            threadProgressBar0.TabIndex = 6;
            // 
            // threadProgressBar1
            // 
            threadProgressBar1.Location = new Point(60, 150);
            threadProgressBar1.Name = "threadProgressBar1";
            threadProgressBar1.Size = new Size(125, 29);
            threadProgressBar1.TabIndex = 7;
            // 
            // threadProgressBar2
            // 
            threadProgressBar2.Location = new Point(60, 225);
            threadProgressBar2.Name = "threadProgressBar2";
            threadProgressBar2.Size = new Size(125, 29);
            threadProgressBar2.TabIndex = 8;
            // 
            // Form1
            // 
            AutoScaleDimensions = new SizeF(8F, 20F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(800, 450);
            Controls.Add(threadProgressBar2);
            Controls.Add(threadProgressBar1);
            Controls.Add(threadProgressBar0);
            Controls.Add(threadTimeInfoBtn2);
            Controls.Add(threadTimeInfoBtn1);
            Controls.Add(threadTimeInfoBtn0);
            Controls.Add(threadSuspendBtn2);
            Controls.Add(threadSuspendBtn1);
            Controls.Add(threadSuspendBtn0);
            Name = "Form1";
            Text = "Form1";
            ResumeLayout(false);
        }

        #endregion

        private Button threadSuspendBtn0;
        private Button threadSuspendBtn1;
        private Button threadSuspendBtn2;
        private Button threadTimeInfoBtn0;
        private Button threadTimeInfoBtn1;
        private Button threadTimeInfoBtn2;
        private ProgressBar threadProgressBar0;
        private ProgressBar threadProgressBar1;
        private ProgressBar threadProgressBar2;
    }
}
