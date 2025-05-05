namespace ThreadSync2
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
            mariaBar = new ProgressBar();
            cosminBar = new ProgressBar();
            laviniaBar = new ProgressBar();
            mariaText = new TextBox();
            cosminText = new TextBox();
            laviniaText = new TextBox();
            startBtn = new Button();
            SuspendLayout();
            // 
            // mariaBar
            // 
            mariaBar.Location = new Point(90, 42);
            mariaBar.Name = "mariaBar";
            mariaBar.Size = new Size(627, 42);
            mariaBar.TabIndex = 0;
            // 
            // cosminBar
            // 
            cosminBar.Location = new Point(356, 120);
            cosminBar.Name = "cosminBar";
            cosminBar.Size = new Size(361, 29);
            cosminBar.TabIndex = 1;
            // 
            // laviniaBar
            // 
            laviniaBar.Location = new Point(508, 200);
            laviniaBar.Name = "laviniaBar";
            laviniaBar.Size = new Size(209, 29);
            laviniaBar.TabIndex = 2;
            // 
            // mariaText
            // 
            mariaText.Location = new Point(18, 42);
            mariaText.Name = "mariaText";
            mariaText.Size = new Size(66, 27);
            mariaText.TabIndex = 3;
            mariaText.Text = "Maria";
            // 
            // cosminText
            // 
            cosminText.Location = new Point(18, 120);
            cosminText.Name = "cosminText";
            cosminText.Size = new Size(66, 27);
            cosminText.TabIndex = 4;
            cosminText.Text = "Cosmin";
            // 
            // laviniaText
            // 
            laviniaText.Location = new Point(18, 200);
            laviniaText.Name = "laviniaText";
            laviniaText.Size = new Size(66, 27);
            laviniaText.TabIndex = 5;
            laviniaText.Text = "Lavinia";
            // 
            // startBtn
            // 
            startBtn.Location = new Point(331, 324);
            startBtn.Name = "startBtn";
            startBtn.Size = new Size(94, 29);
            startBtn.TabIndex = 6;
            startBtn.Text = "Start";
            startBtn.UseVisualStyleBackColor = true;
            startBtn.Click += startBtn_Click;
            // 
            // Form1
            // 
            AutoScaleDimensions = new SizeF(8F, 20F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(800, 450);
            Controls.Add(startBtn);
            Controls.Add(laviniaText);
            Controls.Add(cosminText);
            Controls.Add(mariaText);
            Controls.Add(laviniaBar);
            Controls.Add(cosminBar);
            Controls.Add(mariaBar);
            Name = "Form1";
            Text = "Form1";
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private ProgressBar mariaBar;
        private ProgressBar cosminBar;
        private ProgressBar laviniaBar;
        private TextBox mariaText;
        private TextBox cosminText;
        private TextBox laviniaText;
        private Button startBtn;
    }
}
