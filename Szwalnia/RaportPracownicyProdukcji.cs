﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Szwalnia
{
    public partial class RaportPracownicyProdukcji : Form
    {
        public SzwalniaEntities db;
        public RaportPracownicyProdukcji(SzwalniaEntities db)
        {
            InitializeComponent();
            this.db = db;
            dgvPracownicy.DataSource = db.vPrzydzialZasobow.ToList();
            dgvPracownicy.Columns[6].Visible = false;
            dgvPracownicy.Columns[7].Visible = false;
            dgvPracownicy.Columns[0].HeaderText = "ID procesu produkcyjnego";
            dgvPracownicy.Columns[1].HeaderText = "ID realizacji procesu";
            dgvPracownicy.Columns[2].HeaderText = "Nazwa etapu";
            dgvPracownicy.Columns[3].HeaderText = "ID pracownika";
            dgvPracownicy.Columns[4].HeaderText = "Imię";
            dgvPracownicy.Columns[5].HeaderText = "Nazwisko";
            dgvPracownicy.Columns[8].HeaderText = "Data rozpoczęcia";
            dgvPracownicy.Columns[9].HeaderText = "Data zakończenia";
            cbxEtap.DataSource = db.Rodzaj_Etapu.ToList();
            cbxEtap.DisplayMember = "Nazwa";
            cbxEtap.ValueMember = "Nazwa";
            cbxPracownik.DataSource = db.vWszyscyPracownicyProdukcji.ToList();
            cbxPracownik.DisplayMember = "Pracownik";
            cbxPracownik.ValueMember = "ID_Pracownika";
        }

        private void btnIdProcesu_Click(object sender, EventArgs e)
        {
            dgvPracownicy.DataSource = this.db.vPrzydzialZasobow.Where(proces => proces.ID_procesu_produkcyjnego == nudProces.Value).ToList();
            dgvPracownicy.Columns.OfType<DataGridViewColumn>().ToList().ForEach(kolumna => kolumna.Visible = true);
            dgvPracownicy.Columns[0].Visible = false;
            dgvPracownicy.Columns[6].Visible = false;
            dgvPracownicy.Columns[7].Visible = false;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            dgvPracownicy.DataSource = this.db.vPrzydzialZasobow.Where(etap => etap.Nazwa_etapu == cbxEtap.SelectedValue.ToString()).ToList();
            dgvPracownicy.Columns.OfType<DataGridViewColumn>().ToList().ForEach(kolumna => kolumna.Visible = true);
            dgvPracownicy.Columns[2].Visible = false;
            dgvPracownicy.Columns[6].Visible = false;
            dgvPracownicy.Columns[7].Visible = false;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            int numer = Convert.ToInt32(cbxPracownik.SelectedValue);
            dgvPracownicy.DataSource = this.db.vPrzydzialZasobow.Where(pracownik => pracownik.ID_pracownika == numer).ToList();
            dgvPracownicy.Columns.OfType<DataGridViewColumn>().ToList().ForEach(kolumna => kolumna.Visible = true);
            dgvPracownicy.Columns[6].Visible = false;
            dgvPracownicy.Columns[7].Visible = false;
        }

        private void btnWszystkie_Click(object sender, EventArgs e)
        {
            dgvPracownicy.DataSource = db.vPrzydzialZasobow.ToList();
            dgvPracownicy.Columns[6].Visible = false;
            dgvPracownicy.Columns[7].Visible = false;
        }

        private void btnIdRealizacji_Click(object sender, EventArgs e)
        {
            dgvPracownicy.DataSource = this.db.vPrzydzialZasobow.Where(proces => proces.ID_realizacji_procesu == nudRealizacja.Value).ToList();
            dgvPracownicy.Columns.OfType<DataGridViewColumn>().ToList().ForEach(kolumna => kolumna.Visible = true);
            dgvPracownicy.Columns[1].Visible = false;
            dgvPracownicy.Columns[6].Visible = false;
            dgvPracownicy.Columns[7].Visible = false;
        }

        private void btnData_Click(object sender, EventArgs e)
        {
            dgvPracownicy.DataSource = this.db.vPrzydzialZasobow.Where(data => ((data.Data_rozpoczęcia.Value.Month == dtpData.Value.Month) && (data.Data_rozpoczęcia.Value.Year == dtpData.Value.Year)) | ((data.Data_zakończenia.Value.Month == dtpData.Value.Month) && (data.Data_zakończenia.Value.Year == dtpData.Value.Year)) ).ToList();
            dgvPracownicy.Columns.OfType<DataGridViewColumn>().ToList().ForEach(kolumna => kolumna.Visible = true);
            dgvPracownicy.Columns[6].Visible = false;
            dgvPracownicy.Columns[7].Visible = false;
        }
    }
}
