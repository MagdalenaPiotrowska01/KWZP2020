//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Szwalnia
{
    using System;
    using System.Collections.Generic;
    
    public partial class vIdZamowienieElementProcesProdukcyjny
    {
        public int ID_Zamowienie_Element { get; set; }
        public int ID_Procesu_Produkcyjnego { get; set; }
        public int Expr1 { get; set; }
        public Nullable<System.DateTime> Proponowana_data_dostawy_materialu { get; set; }
        public Nullable<System.DateTime> Data_Rozpoczecia { get; set; }
        public Nullable<System.DateTime> Data_Zakonczenia { get; set; }
        public string Uwagi { get; set; }
    }
}