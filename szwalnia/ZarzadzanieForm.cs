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
    public partial class ZarzadzanieForm : Form
    {
        public SzwalniaEntities db;
        public ZarzadzanieForm(SzwalniaEntities szwalnia)
        {
            db = szwalnia;
            InitializeComponent();
        }
        private void btnKlienciForm_MouseClick(object sender, MouseEventArgs e)
        {
            WyborKlienta wyborKlienta = new WyborKlienta(db);
            wyborKlienta.Show();
            this.Close();
        }

        private void btnWroc_Click(object sender, EventArgs e)
        {

        }

        private void btnZamknij_MouseClick(object sender, MouseEventArgs e)
        {
             this.Close();
        }

        private void btnZamknij(object sender, EventArgs e)
        {

        }

        private void btnFakturyZewnetrzne_Click(object sender, EventArgs e)
        {

        }

        private void btnFakturyZewnetrzne_MouseClick(object sender, MouseEventArgs e)
        {

        }

        private void ZarzadzanieForm_Load(object sender, EventArgs e)
        {

        }
    }
}
