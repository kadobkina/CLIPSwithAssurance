namespace Alchemy
{
    partial class Form1
    {
        /// <summary>
        /// Обязательная переменная конструктора.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Освободить все используемые ресурсы.
        /// </summary>
        /// <param name="disposing">истинно, если управляемый ресурс должен быть удален; иначе ложно.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Код, автоматически созданный конструктором форм Windows

        /// <summary>
        /// Требуемый метод для поддержки конструктора — не изменяйте 
        /// содержимое этого метода с помощью редактора кода.
        /// </summary>
        private void InitializeComponent()
        {
            this.labelS = new System.Windows.Forms.Label();
            this.start = new System.Windows.Forms.Button();
            this.textBox2 = new System.Windows.Forms.TextBox();
            this.next = new System.Windows.Forms.Button();
            this.labelT = new System.Windows.Forms.Label();
            this.allFactsListBox = new System.Windows.Forms.ListBox();
            this.initialFactsListBox = new System.Windows.Forms.ListBox();
            this.terminalsListBox = new System.Windows.Forms.ListBox();
            this.label1 = new System.Windows.Forms.Label();
            this.allButton = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // labelS
            // 
            this.labelS.AutoSize = true;
            this.labelS.Location = new System.Drawing.Point(17, 19);
            this.labelS.Name = "labelS";
            this.labelS.Size = new System.Drawing.Size(140, 20);
            this.labelS.TabIndex = 9;
            this.labelS.Text = "Исходные факты";
            // 
            // start
            // 
            this.start.Enabled = false;
            this.start.Location = new System.Drawing.Point(666, 554);
            this.start.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.start.Name = "start";
            this.start.Size = new System.Drawing.Size(163, 39);
            this.start.TabIndex = 4;
            this.start.Text = "Начать";
            this.start.UseVisualStyleBackColor = true;
            this.start.Click += new System.EventHandler(this.start_Click);
            // 
            // textBox2
            // 
            this.textBox2.Location = new System.Drawing.Point(670, 45);
            this.textBox2.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.textBox2.Multiline = true;
            this.textBox2.Name = "textBox2";
            this.textBox2.ScrollBars = System.Windows.Forms.ScrollBars.Both;
            this.textBox2.Size = new System.Drawing.Size(501, 484);
            this.textBox2.TabIndex = 2;
            // 
            // next
            // 
            this.next.Enabled = false;
            this.next.Location = new System.Drawing.Point(1008, 554);
            this.next.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.next.Name = "next";
            this.next.Size = new System.Drawing.Size(163, 39);
            this.next.TabIndex = 11;
            this.next.Text = "Один шаг";
            this.next.UseVisualStyleBackColor = true;
            this.next.Click += new System.EventHandler(this.next_Click);
            // 
            // labelT
            // 
            this.labelT.AutoSize = true;
            this.labelT.Location = new System.Drawing.Point(405, 19);
            this.labelT.Name = "labelT";
            this.labelT.Size = new System.Drawing.Size(93, 20);
            this.labelT.TabIndex = 8;
            this.labelT.Text = "Все факты";
            // 
            // allFactsListBox
            // 
            this.allFactsListBox.FormattingEnabled = true;
            this.allFactsListBox.ItemHeight = 20;
            this.allFactsListBox.Location = new System.Drawing.Point(346, 45);
            this.allFactsListBox.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.allFactsListBox.Name = "allFactsListBox";
            this.allFactsListBox.Size = new System.Drawing.Size(301, 484);
            this.allFactsListBox.TabIndex = 5;
            this.allFactsListBox.KeyDown += new System.Windows.Forms.KeyEventHandler(this.allFactsListBox_KeyDown);
            this.allFactsListBox.MouseDoubleClick += new System.Windows.Forms.MouseEventHandler(this.allFactsListBox_MouseDoubleClick);
            // 
            // initialFactsListBox
            // 
            this.initialFactsListBox.FormattingEnabled = true;
            this.initialFactsListBox.ItemHeight = 20;
            this.initialFactsListBox.Location = new System.Drawing.Point(13, 45);
            this.initialFactsListBox.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.initialFactsListBox.Name = "initialFactsListBox";
            this.initialFactsListBox.Size = new System.Drawing.Size(301, 184);
            this.initialFactsListBox.TabIndex = 12;
            this.initialFactsListBox.KeyDown += new System.Windows.Forms.KeyEventHandler(this.initialFactsListBox_KeyDown);
            this.initialFactsListBox.MouseDoubleClick += new System.Windows.Forms.MouseEventHandler(this.initialFactsListBox_MouseDoubleClick);
            // 
            // terminalsListBox
            // 
            this.terminalsListBox.FormattingEnabled = true;
            this.terminalsListBox.ItemHeight = 20;
            this.terminalsListBox.Location = new System.Drawing.Point(13, 285);
            this.terminalsListBox.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.terminalsListBox.Name = "terminalsListBox";
            this.terminalsListBox.Size = new System.Drawing.Size(301, 244);
            this.terminalsListBox.TabIndex = 13;
            this.terminalsListBox.MouseDoubleClick += new System.Windows.Forms.MouseEventHandler(this.terminalsListBox_MouseDoubleClick);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(12, 250);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(95, 20);
            this.label1.TabIndex = 14;
            this.label1.Text = "Терминалы";
            // 
            // allButton
            // 
            this.allButton.Enabled = false;
            this.allButton.Location = new System.Drawing.Point(837, 554);
            this.allButton.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.allButton.Name = "allButton";
            this.allButton.Size = new System.Drawing.Size(163, 39);
            this.allButton.TabIndex = 15;
            this.allButton.Text = "Вывести всё";
            this.allButton.UseVisualStyleBackColor = true;
            this.allButton.Click += new System.EventHandler(this.allButton_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1198, 609);
            this.Controls.Add(this.allButton);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.terminalsListBox);
            this.Controls.Add(this.initialFactsListBox);
            this.Controls.Add(this.next);
            this.Controls.Add(this.allFactsListBox);
            this.Controls.Add(this.labelT);
            this.Controls.Add(this.labelS);
            this.Controls.Add(this.textBox2);
            this.Controls.Add(this.start);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.Name = "Form1";
            this.Text = "Алхимия";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private System.Windows.Forms.Label labelS;
        private System.Windows.Forms.TextBox textBox2;
        private System.Windows.Forms.Button start;
        private System.Windows.Forms.Button next;
        private System.Windows.Forms.Label labelT;
        private System.Windows.Forms.ListBox allFactsListBox;
        private System.Windows.Forms.ListBox initialFactsListBox;
        private System.Windows.Forms.ListBox terminalsListBox;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button allButton;
    }
}

