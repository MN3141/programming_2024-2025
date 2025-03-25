namespace TaskManager
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
            endTaskBtn = new Button();
            updateButton = new Button();
            listBox1 = new ListBox();
            SuspendLayout();
            // 
            // endTaskBtn
            // 
            endTaskBtn.Location = new Point(610, 163);
            endTaskBtn.Name = "endTaskBtn";
            endTaskBtn.Size = new Size(94, 29);
            endTaskBtn.TabIndex = 0;
            endTaskBtn.Text = "End Task";
            endTaskBtn.UseVisualStyleBackColor = true;
            endTaskBtn.Click += endTaskBtn_Click;
            // 
            // updateButton
            // 
            updateButton.Location = new Point(488, 163);
            updateButton.Name = "updateButton";
            updateButton.Size = new Size(94, 29);
            updateButton.TabIndex = 4;
            updateButton.Text = "Update List";
            updateButton.UseVisualStyleBackColor = true;
            updateButton.Click += updateButton_Click;
            // 
            // listBox1
            // 
            listBox1.FormattingEnabled = true;
            listBox1.Location = new Point(75, 122);
            listBox1.Name = "listBox1";
            listBox1.Size = new Size(222, 284);
            listBox1.TabIndex = 5;
            listBox1.SelectedIndexChanged += listBox1_SelectedIndexChanged;
            // 
            // Form1
            // 
            AutoScaleDimensions = new SizeF(8F, 20F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(800, 450);
            Controls.Add(listBox1);
            Controls.Add(updateButton);
            Controls.Add(endTaskBtn);
            Name = "Form1";
            Text = "Form1";
            ResumeLayout(false);
        }

        #endregion

        private Button endTaskBtn;
        private Button button2;
        private ListBox listBox1;
        private Button updateButton;
    }
}
