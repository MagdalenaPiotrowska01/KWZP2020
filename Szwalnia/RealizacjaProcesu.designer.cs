﻿namespace Szwalnia
{
    partial class RealizacjaProcesu
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
            this.dgvRealizacjaProcesu = new System.Windows.Forms.DataGridView();
            this.lblProces = new System.Windows.Forms.Label();
            this.btnAnuluj = new System.Windows.Forms.Button();
            this.btnZapisz = new System.Windows.Forms.Button();
            this.btnNowy = new System.Windows.Forms.Button();
            this.lblOpis = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.dgvRealizacjaProcesu)).BeginInit();
            this.SuspendLayout();
            // 
            // dgvRealizacjaProcesu
            // 
            this.dgvRealizacjaProcesu.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvRealizacjaProcesu.Location = new System.Drawing.Point(53, 90);
            this.dgvRealizacjaProcesu.Name = "dgvRealizacjaProcesu";
            this.dgvRealizacjaProcesu.Size = new System.Drawing.Size(479, 216);
            this.dgvRealizacjaProcesu.TabIndex = 0;
            this.dgvRealizacjaProcesu.CellDoubleClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgvRealizacjaProcesu_CellDoubleClick);
            // 
            // lblProces
            // 
            this.lblProces.AutoSize = true;
            this.lblProces.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this.lblProces.Location = new System.Drawing.Point(92, 39);
            this.lblProces.Name = "lblProces";
            this.lblProces.Size = new System.Drawing.Size(51, 20);
            this.lblProces.TabIndex = 1;
            this.lblProces.Text = "label1";
            // 
            // btnAnuluj
            // 
            this.btnAnuluj.Font = new System.Drawing.Font("Microsoft Sans Serif", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this.btnAnuluj.Location = new System.Drawing.Point(365, 364);
            this.btnAnuluj.Name = "btnAnuluj";
            this.btnAnuluj.Size = new System.Drawing.Size(80, 50);
            this.btnAnuluj.TabIndex = 4;
            this.btnAnuluj.Text = "Anuluj";
            this.btnAnuluj.UseVisualStyleBackColor = true;
            this.btnAnuluj.Click += new System.EventHandler(this.btnAnuluj_Click);
            // 
            // btnZapisz
            // 
            this.btnZapisz.Font = new System.Drawing.Font("Microsoft Sans Serif", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this.btnZapisz.Location = new System.Drawing.Point(244, 364);
            this.btnZapisz.Name = "btnZapisz";
            this.btnZapisz.Size = new System.Drawing.Size(80, 50);
            this.btnZapisz.TabIndex = 5;
            this.btnZapisz.Text = "Zapisz";
            this.btnZapisz.UseVisualStyleBackColor = true;
            this.btnZapisz.Click += new System.EventHandler(this.btnZapisz_Click);
            // 
            // btnNowy
            // 
            this.btnNowy.Font = new System.Drawing.Font("Microsoft Sans Serif", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this.btnNowy.Location = new System.Drawing.Point(127, 364);
            this.btnNowy.Name = "btnNowy";
            this.btnNowy.Size = new System.Drawing.Size(80, 50);
            this.btnNowy.TabIndex = 6;
            this.btnNowy.Text = "Nowy";
            this.btnNowy.UseVisualStyleBackColor = true;
            this.btnNowy.Click += new System.EventHandler(this.btnNowy_Click);
            // 
            // lblOpis
            // 
            this.lblOpis.AutoSize = true;
            this.lblOpis.Font = new System.Drawing.Font("Microsoft Sans Serif", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this.lblOpis.Location = new System.Drawing.Point(50, 320);
            this.lblOpis.Name = "lblOpis";
            this.lblOpis.Size = new System.Drawing.Size(466, 18);
            this.lblOpis.TabIndex = 9;
            this.lblOpis.Text = "Kliknij dwukrotnie na realizację, aby zmodyfikować przydział zasobów";
            // 
            // RealizacjaProcesu
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.ClientSize = new System.Drawing.Size(587, 426);
            this.Controls.Add(this.lblOpis);
            this.Controls.Add(this.btnNowy);
            this.Controls.Add(this.btnAnuluj);
            this.Controls.Add(this.btnZapisz);
            this.Controls.Add(this.lblProces);
            this.Controls.Add(this.dgvRealizacjaProcesu);
            this.Name = "RealizacjaProcesu";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Realizacja Procesu";
            ((System.ComponentModel.ISupportInitialize)(this.dgvRealizacjaProcesu)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView dgvRealizacjaProcesu;
        private System.Windows.Forms.Label lblProces;
        private System.Windows.Forms.Button btnAnuluj;
        private System.Windows.Forms.Button btnZapisz;
        private System.Windows.Forms.Button btnNowy;
        private System.Windows.Forms.Label lblOpis;
    }
}