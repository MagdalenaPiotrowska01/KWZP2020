﻿namespace Szwalnia
{
    partial class UkladMagazynu
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(UkladMagazynu));
            this.btnZnajdzPolke = new System.Windows.Forms.Button();
            this.btnDodajRegal = new System.Windows.Forms.Button();
            this.btnDodajPolke = new System.Windows.Forms.Button();
            this.btnDodajRozmiar = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.nudNumerPolki = new System.Windows.Forms.NumericUpDown();
            this.label2 = new System.Windows.Forms.Label();
            this.lblRegal = new System.Windows.Forms.Label();
            this.btnPolkiNaRegalach = new System.Windows.Forms.Button();
            this.lblWymiary = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.nudNumerPolki)).BeginInit();
            this.SuspendLayout();
            // 
            // btnZnajdzPolke
            // 
            this.btnZnajdzPolke.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F);
            this.btnZnajdzPolke.Location = new System.Drawing.Point(129, 145);
            this.btnZnajdzPolke.Name = "btnZnajdzPolke";
            this.btnZnajdzPolke.Size = new System.Drawing.Size(86, 32);
            this.btnZnajdzPolke.TabIndex = 2;
            this.btnZnajdzPolke.Text = "Szukaj";
            this.btnZnajdzPolke.UseVisualStyleBackColor = true;
            this.btnZnajdzPolke.Click += new System.EventHandler(this.btnZnajdzPolke_Click);
            // 
            // btnDodajRegal
            // 
            this.btnDodajRegal.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F);
            this.btnDodajRegal.Location = new System.Drawing.Point(38, 202);
            this.btnDodajRegal.Name = "btnDodajRegal";
            this.btnDodajRegal.Size = new System.Drawing.Size(135, 33);
            this.btnDodajRegal.TabIndex = 3;
            this.btnDodajRegal.Text = "Dodaj regał";
            this.btnDodajRegal.UseVisualStyleBackColor = true;
            this.btnDodajRegal.Click += new System.EventHandler(this.btnDodajRegal_Click);
            // 
            // btnDodajPolke
            // 
            this.btnDodajPolke.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F);
            this.btnDodajPolke.Location = new System.Drawing.Point(38, 241);
            this.btnDodajPolke.Name = "btnDodajPolke";
            this.btnDodajPolke.Size = new System.Drawing.Size(135, 33);
            this.btnDodajPolke.TabIndex = 4;
            this.btnDodajPolke.Text = "Dodaj półkę";
            this.btnDodajPolke.UseVisualStyleBackColor = true;
            this.btnDodajPolke.Click += new System.EventHandler(this.btnDodajPolke_Click);
            // 
            // btnDodajRozmiar
            // 
            this.btnDodajRozmiar.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F);
            this.btnDodajRozmiar.ImageAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.btnDodajRozmiar.Location = new System.Drawing.Point(38, 280);
            this.btnDodajRozmiar.Name = "btnDodajRozmiar";
            this.btnDodajRozmiar.Size = new System.Drawing.Size(135, 33);
            this.btnDodajRozmiar.TabIndex = 5;
            this.btnDodajRozmiar.Text = "Dodaj rozmiar półki";
            this.btnDodajRozmiar.UseVisualStyleBackColor = true;
            this.btnDodajRozmiar.Click += new System.EventHandler(this.btnDodajRozmiar_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 20F);
            this.label1.Location = new System.Drawing.Point(60, 23);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(216, 31);
            this.label1.TabIndex = 4;
            this.label1.Text = "Układ magazynu";
            // 
            // nudNumerPolki
            // 
            this.nudNumerPolki.Font = new System.Drawing.Font("Microsoft Sans Serif", 15F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this.nudNumerPolki.Location = new System.Drawing.Point(80, 108);
            this.nudNumerPolki.Name = "nudNumerPolki";
            this.nudNumerPolki.Size = new System.Drawing.Size(77, 30);
            this.nudNumerPolki.TabIndex = 1;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 14F);
            this.label2.Location = new System.Drawing.Point(115, 77);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(122, 24);
            this.label2.TabIndex = 6;
            this.label2.Text = "Znajdź półkę";
            // 
            // lblRegal
            // 
            this.lblRegal.AutoSize = true;
            this.lblRegal.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this.lblRegal.Location = new System.Drawing.Point(164, 105);
            this.lblRegal.Name = "lblRegal";
            this.lblRegal.Size = new System.Drawing.Size(80, 20);
            this.lblRegal.TabIndex = 7;
            this.lblRegal.Text = "REGAŁ: ";
            // 
            // btnPolkiNaRegalach
            // 
            this.btnPolkiNaRegalach.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F);
            this.btnPolkiNaRegalach.Location = new System.Drawing.Point(188, 202);
            this.btnPolkiNaRegalach.Name = "btnPolkiNaRegalach";
            this.btnPolkiNaRegalach.Size = new System.Drawing.Size(114, 111);
            this.btnPolkiNaRegalach.TabIndex = 6;
            this.btnPolkiNaRegalach.Text = "Widok półek na regałach";
            this.btnPolkiNaRegalach.UseVisualStyleBackColor = true;
            this.btnPolkiNaRegalach.Click += new System.EventHandler(this.btnPolkiNaRegalach_Click);
            // 
            // lblWymiary
            // 
            this.lblWymiary.AutoSize = true;
            this.lblWymiary.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this.lblWymiary.Location = new System.Drawing.Point(165, 125);
            this.lblWymiary.Name = "lblWymiary";
            this.lblWymiary.Size = new System.Drawing.Size(56, 15);
            this.lblWymiary.TabIndex = 8;
            this.lblWymiary.Text = "Wymiary:";
            // 
            // UkladMagazynu
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(339, 332);
            this.Controls.Add(this.lblWymiary);
            this.Controls.Add(this.btnPolkiNaRegalach);
            this.Controls.Add(this.lblRegal);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.nudNumerPolki);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.btnDodajRozmiar);
            this.Controls.Add(this.btnDodajPolke);
            this.Controls.Add(this.btnDodajRegal);
            this.Controls.Add(this.btnZnajdzPolke);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "UkladMagazynu";
            this.Text = "Układ magazynu";
            this.FormClosed += new System.Windows.Forms.FormClosedEventHandler(this.UkladMagazynu_FormClosed);
            ((System.ComponentModel.ISupportInitialize)(this.nudNumerPolki)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button btnZnajdzPolke;
        private System.Windows.Forms.Button btnDodajRegal;
        private System.Windows.Forms.Button btnDodajPolke;
        private System.Windows.Forms.Button btnDodajRozmiar;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.NumericUpDown nudNumerPolki;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label lblRegal;
        private System.Windows.Forms.Button btnPolkiNaRegalach;
        private System.Windows.Forms.Label lblWymiary;
    }
}