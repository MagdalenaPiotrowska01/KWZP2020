﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Drawing.Text;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Szwalnia
{
    public partial class PopupAcceptDeny : Form
    {
        public SzwalniaEntities db;
        public int intIDZamowienie;
        public int intIDZamowienieElement;
        public int intElementID;
        public int intIDDostawcy;
        public int intIDDostawy;
        public int intPolka;
        public int intDostawa;
        public int intIlosc;
        public int intPracownikID;
        public int intOferta;
        public bool boolCzyCancel = false;
        public bool czyOferta;
        public bool czyWydanie=false;
        Dostawcy_Zaopatrzenie dostawcaWybrany = new Dostawcy_Zaopatrzenie();
        public PopupAcceptDeny(bool czyOferta, int intIDDostawcy, int intIDZamowienie, int intIlosc, int intOferta, int intElementID)
        {
            InitializeComponent();
            db = Start.szwalnia;
            this.czyOferta = czyOferta;
            this.intIDZamowienie = intIDZamowienie;
            this.intIlosc = intIlosc;
            this.intOferta = intOferta;
            this.intElementID = intElementID;
            this.intIDDostawcy = intIDDostawcy;
            dostawcaWybrany = db.Dostawcy_Zaopatrzenie.Where(wybrany => wybrany.ID_Dostawcy == intIDDostawcy).First();
            lblInfo.Text = "Czy na pewno chcesz wybrać ofertę " + dostawcaWybrany.Nazwa + " ?";
        }
        public PopupAcceptDeny(int intPolka, int intDostawa, int intElementID, int intIlosc, int intIDZamowienie)
        {
            InitializeComponent();
            db = Start.szwalnia;
            czyOferta = false;
            this.intIDZamowienie = intIDZamowienie;
            this.intPolka = intPolka;
            this.intDostawa = intDostawa;
            this.intElementID = intElementID;
            this.intIlosc = intIlosc;
            lblInfo.Text = "Czy na pewno chcesz wybrac materiał z półki nr " + Convert.ToString(intPolka)+"?";
        }
        public PopupAcceptDeny(bool czyWydanie,int intIDZamowienia, int intIDZamowieniaElement, int intIDElement, int intIDDostawy, int intIDPolka, int intIlosc, int intPracownikID)
        {
            InitializeComponent();
            db = Start.szwalnia;
            this.czyWydanie = czyWydanie;
            this.intIDZamowienie = intIDZamowienia;
            this.intIDZamowienieElement = intIDZamowieniaElement;
            this.intElementID = intIDElement;
            this.intIDDostawy = intIDDostawy;
            this.intPolka = intIDPolka;
            this.intIlosc = intIlosc;
            this.intPracownikID = intPracownikID;
            lblInfo.Text = "Czy na pewno chcesz wydać materiał?";
        }

        private void btnAccept_Click(object sender, EventArgs e)
        {
            if (!czyWydanie)
            {
                //akcja zapisz dostawce/polke
                if (czyOferta)
                {
                    //wstawianie do tabel
                    if (db.vDostawcyDostawDoZamowien.Where(poszukiwanyDostawca => poszukiwanyDostawca.ID_Dostawcy == intIDDostawcy).Where(poszukiwanyDostawca => poszukiwanyDostawca.ID_Zamowienia == intIDZamowienie).Any())
                    {
                        vDostawcyDostawDoZamowien poszukiwanyZestawDanych = db.vDostawcyDostawDoZamowien.Where(poszukiwanyDostawca => poszukiwanyDostawca.ID_Dostawcy == intIDDostawcy).Where(poszukiwanyDostawca => poszukiwanyDostawca.ID_Zamowienia == intIDZamowienie).First();
                        int intIDDostawy = poszukiwanyZestawDanych.ID_Dostawy;
                        Dostawy_Zawartosc nowaZawartoscDoDostawy = new Dostawy_Zawartosc();
                        nowaZawartoscDoDostawy.ID_Dostawy = intIDDostawy;
                        nowaZawartoscDoDostawy.ID_Element = intElementID;
                        nowaZawartoscDoDostawy.ID_oferta = intOferta;
                        nowaZawartoscDoDostawy.Ilosc_Dostarczona = intIlosc;
                        db.Dostawy_Zawartosc.Add(nowaZawartoscDoDostawy);
                        db.SaveChanges();
                        Start.DataBaseRefresh();
                    }
                    else
                    {
                        //nowa dostawa
                        Zamowienia_Dostawy nowaDostawa = new Zamowienia_Dostawy();
                        nowaDostawa.ID_statusu = 1;
                        nowaDostawa.ID_Zamowienia = intIDZamowienie;
                        db.Zamowienia_Dostawy.Add(nowaDostawa);
                        db.SaveChanges();
                        Start.DataBaseRefresh();
                        //nowa zawartosc
                        int intIDDostawy = db.Zamowienia_Dostawy.Count();
                        Dostawy_Zawartosc nowaZawartosc = new Dostawy_Zawartosc();
                        nowaZawartosc.ID_Dostawy = intIDDostawy;
                        nowaZawartosc.ID_Element = intElementID;
                        nowaZawartosc.ID_oferta = intOferta;
                        nowaZawartosc.Ilosc_Dostarczona = intIlosc;
                        db.Dostawy_Zawartosc.Add(nowaZawartosc);
                        db.SaveChanges();
                        Start.DataBaseRefresh();
                    }
                    //zamykanie formularzy
                    //zamykanie formularzy
                    WyborOferty.czyZamknietyPrzezInny = true;
                    Application.OpenForms["WyborOferty"].Close();
                    if (Application.OpenForms.OfType<DodawanieDostaw>().Count() > 0)
                    {
                        DodawanieDostaw.czyZamknietyPrzezInny = true;
                        Application.OpenForms["DodawanieDostaw"].Close();
                    }
                    WyborOferty.czyZamknietyPrzezInny = false;
                    DodawanieDostaw formularzDodawanieDostaw = new DodawanieDostaw(!db.vMaterialyDoZamowieniaBrak.Where(elementDoZamowienia => elementDoZamowienia.ID_Element > 0).Any());
                    formularzDodawanieDostaw.Show();
                    boolCzyCancel = true;
                    this.Close();
                }
                else
                {
                    //wstawianie do tabel
                    Zamowienia_Dostawy_Wlasne nowePrzypisanieDostawyZasobow = new Zamowienia_Dostawy_Wlasne();
                    nowePrzypisanieDostawyZasobow.ID_miejsca = 2;
                    nowePrzypisanieDostawyZasobow.ID_Zamowienia = intIDZamowienie;
                    db.Zamowienia_Dostawy_Wlasne.Add(nowePrzypisanieDostawyZasobow);
                    db.SaveChanges();
                    int IDDostawyWlasne = db.Zamowienia_Dostawy_Wlasne.Count();
                    Dostawy_Wlasne_Zawartosc nowePrzypisanieZawartosciDostawyZasobow = new Dostawy_Wlasne_Zawartosc();
                    nowePrzypisanieZawartosciDostawyZasobow.ID_Zamowienia_dostawy_wlasne = IDDostawyWlasne;
                    nowePrzypisanieZawartosciDostawyZasobow.ID_Element = intElementID;
                    nowePrzypisanieZawartosciDostawyZasobow.ID_Dostawy = intDostawa;
                    nowePrzypisanieZawartosciDostawyZasobow.Ilosc = intIlosc;
                    db.Dostawy_Wlasne_Zawartosc.Add(nowePrzypisanieZawartosciDostawyZasobow);
                    db.SaveChanges();
                    Zawartosc polkaZKtorejWzieto = db.Zawartosc.Where(polkaWybrana => polkaWybrana.ID_Polka == intPolka).First();
                    db.Zawartosc.Remove(polkaZKtorejWzieto);
                    db.SaveChanges();
                    Start.DataBaseRefresh();
                    //zamykanie formularzy
                    WyborOferty.czyZamknietyPrzezInny = true;
                    Application.OpenForms["WyborOferty"].Close();
                    if (Application.OpenForms.OfType<DodawanieDostaw>().Count() > 0)
                    {
                        DodawanieDostaw.czyZamknietyPrzezInny = true;
                        Application.OpenForms["DodawanieDostaw"].Close();
                    }
                    DodawanieDostaw formularzDodawanieDostaw = new DodawanieDostaw(!db.vMaterialyDoZamowieniaBrak.Where(elementDoZamowienia => elementDoZamowienia.ID_Element > 0).Any());
                    formularzDodawanieDostaw.Show();
                    boolCzyCancel = true;
                    this.Close();
                }
            }
            else
            {
                Dostarczenia_Wewn noweWydanie = new Dostarczenia_Wewn();
                noweWydanie.ID_Pracownicy = intPracownikID;
                noweWydanie.ID_Dostawy = intIDDostawy;
                noweWydanie.ID_Zamowienie_element = intIDZamowienieElement;
                noweWydanie.ID_element = intElementID;
                noweWydanie.Ilosc_Dostarczona = (-1)*intIlosc;
                noweWydanie.ID_Miejsca = 2;
                noweWydanie.Data_Dostarczenia = (Convert.ToString(DateTime.Now)).Substring(0,10);
                db.Dostarczenia_Wewn.Add(noweWydanie);
                db.SaveChanges();
                Zawartosc polkaDoWyczyszczenia = db.Zawartosc.Where(polka => polka.ID_Polka == intPolka).First();
                db.Zawartosc.Remove(polkaDoWyczyszczenia);
                db.SaveChanges();
                Start.DataBaseRefresh();
                WydajMaterialProdukcji.czyZamknietyPrzezInny = true;
                Application.OpenForms[typeof(WydajMaterialProdukcji).Name].Close();
                WydajMaterialProdukcji.czyZamknietyPrzezInny = false;
                WydajMaterialProdukcji wydajKolejny = new WydajMaterialProdukcji();
                wydajKolejny.Show();
                boolCzyCancel = true;
                this.Close();
                

            }
        }

        private void btnDeny_Click(object sender, EventArgs e)
        {
            //akcja powrot
            if (!czyWydanie)
            {
                boolCzyCancel = true;
                this.Close();
            }
            else
            {
                boolCzyCancel = true;
                this.Close();
            }
        }

        private void PopupAcceptDeny_FormClosed(object sender, FormClosedEventArgs e)
        {
            if (!boolCzyCancel)
            {
                Application.OpenForms[typeof(ObslugaDostaw).Name].Show();
                if (Application.OpenForms.OfType<WydajMaterialProdukcji>().Count() > 0)
                {
                    Application.OpenForms[typeof(WydajMaterialProdukcji).Name].Close();
                }
                if (Application.OpenForms.OfType<WyborOferty>().Count() > 0)
                {
                    Application.OpenForms[typeof(WyborOferty).Name].Close();
                }
            }
            
        }
    }
}
