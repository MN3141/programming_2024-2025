namespace ThreadManager
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
            threadButton0 = new Button();
            threadButton1 = new Button();
            threadButton2 = new Button();
            progressBar0 = new ProgressBar();
            progressBar1 = new ProgressBar();
            progressBar2 = new ProgressBar();
            SuspendLayout();
            // 
            // threadButton0
            // 
            threadButton0.Location = new Point(534, 90);
            threadButton0.Name = "threadButton0";
            threadButton0.Size = new Size(94, 29);
            threadButton0.TabIndex = 0;
            threadButton0.Text = "Suspend";
            threadButton0.UseVisualStyleBackColor = true;
            threadButton0.Click += processButton0_Click;
            // 
            // threadButton1
            // 
            threadButton1.Location = new Point(534, 159);
            threadButton1.Name = "threadButton1";
            threadButton1.Size = new Size(94, 29);
            threadButton1.TabIndex = 1;
            threadButton1.Text = "Suspend";
            threadButton1.UseVisualStyleBackColor = true;
            threadButton1.Click += processButton1_Click;
            // 
            // threadButton2
            // 
            threadButton2.Location = new Point(534, 245);
            threadButton2.Name = "threadButton2";
            threadButton2.Size = new Size(94, 29);
            threadButton2.TabIndex = 2;
            threadButton2.Text = "Suspend";
            threadButton2.UseVisualStyleBackColor = true;
            threadButton2.Click += processButton2_Click;
            // 
            // progressBar0
            // 
            progressBar0.Location = new Point(139, 90);
            progressBar0.Maximum = 9999991;
            progressBar0.Name = "progressBar0";
            progressBar0.Size = new Size(125, 29);
            progressBar0.Step = 1;
            progressBar0.TabIndex = 3;
            // 
            // progressBar1
            // 
            progressBar1.Location = new Point(139, 159);
            progressBar1.Maximum = 9999991;
            progressBar1.Name = "progressBar1";
            progressBar1.Size = new Size(125, 29);
            progressBar1.Step = 1;
            progressBar1.TabIndex = 4;
            // 
            // progressBar2
            // 
            progressBar2.Location = new Point(139, 245);
            progressBar2.Maximum = 9999991;
            progressBar2.Name = "progressBar2";
            progressBar2.Size = new Size(125, 29);
            progressBar2.Step = 1;
            progressBar2.TabIndex = 5;
            // 
            // Form1
            // 
            AutoScaleDimensions = new SizeF(8F, 20F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(800, 450);
            Controls.Add(progressBar2);
            Controls.Add(progressBar1);
            Controls.Add(progressBar0);
            Controls.Add(threadButton2);
            Controls.Add(threadButton1);
            Controls.Add(threadButton0);
            Name = "Form1";
            Text = "Form1";
            ResumeLayout(false);
        }

        #endregion

        private Button threadButton0;
        private Button threadButton1;
        private Button threadButton2;
        private ProgressBar progressBar0;
        private ProgressBar progressBar1;
        private ProgressBar progressBar2;
    }
}
