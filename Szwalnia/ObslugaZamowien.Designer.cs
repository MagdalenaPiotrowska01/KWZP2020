namespace Szwalnia
{
    partial class ObslugaZamowien
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
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
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(ObslugaZamowien));
            this.btnAddWorkersDeliverers = new System.Windows.Forms.Button();
            this.btnOdbior = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // btnAddWorkersDeliverers
            // 
            this.btnAddWorkersDeliverers.BackColor = System.Drawing.SystemColors.Control;
            this.btnAddWorkersDeliverers.Location = new System.Drawing.Point(16, 15);
            this.btnAddWorkersDeliverers.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.btnAddWorkersDeliverers.Name = "btnAddWorkersDeliverers";
            this.btnAddWorkersDeliverers.Size = new System.Drawing.Size(341, 137);
            this.btnAddWorkersDeliverers.TabIndex = 1;
            this.btnAddWorkersDeliverers.Text = "Przypisz pracowników i kurierów";
            this.btnAddWorkersDeliverers.UseVisualStyleBackColor = false;
            this.btnAddWorkersDeliverers.Click += new System.EventHandler(this.btnAddWorkersDeliverers_Click);
            // 
            // btnOdbior
            // 
            this.btnOdbior.BackColor = System.Drawing.SystemColors.Control;
            this.btnOdbior.Location = new System.Drawing.Point(16, 172);
            this.btnOdbior.Margin = new System.Windows.Forms.Padding(4);
            this.btnOdbior.Name = "btnOdbior";
            this.btnOdbior.Size = new System.Drawing.Size(341, 137);
            this.btnOdbior.TabIndex = 2;
            this.btnOdbior.Text = "Odbiór zamowienia z produkcji";
            this.btnOdbior.UseVisualStyleBackColor = false;
            this.btnOdbior.Click += new System.EventHandler(this.btnOdbior_Click);
            // 
            // ObslugaZamowien
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1067, 554);
            this.Controls.Add(this.btnOdbior);
            this.Controls.Add(this.btnAddWorkersDeliverers);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.Name = "ObslugaZamowien";
            this.Text = "ObslugaZamowien";
            this.FormClosed += new System.Windows.Forms.FormClosedEventHandler(this.ObslugaZamowien_FormClosed);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button btnAddWorkersDeliverers;
        private System.Windows.Forms.Button btnOdbior;
    }
}