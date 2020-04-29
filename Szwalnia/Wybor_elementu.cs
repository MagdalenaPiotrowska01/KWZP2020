﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Runtime.InteropServices;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Szwalnia
{
    public partial class Wybor_elementu : Form
    {
        public SzwalniaEntities db;

        public Wybor_elementu(SzwalniaEntities przekazana)
        {
            InitializeComponent();
            db = przekazana;
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void Wybor_elementu_Load(object sender, EventArgs e)
        {

        }

        private void btnSearch_Click(object sender, EventArgs e)
        {
            if (numID.Value > 0)
            {
                lblError.Text = "";
                Element_szczegoly Szczegoly_element = new Element_szczegoly(db, Decimal.ToInt32(numID.Value));
                Szczegoly_element.Show();
                this.Close();
            }
            else
            {
                lblError.Text = "Bledne ID";
            }                
        }
    }
}
