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
    
    public partial class Zamowienia_Przydzial
    {
        public int ID_Zamowienia_Przydzial { get; set; }
        public Nullable<int> ID_Zamowienia { get; set; }
        public Nullable<int> ID_Pracownicy { get; set; }
        public Nullable<int> ID_Umowy { get; set; }
    
        public virtual Pracownicy Pracownicy { get; set; }
        public virtual Umowy_Kurierzy Umowy_Kurierzy { get; set; }
        public virtual Zamowienia Zamowienia { get; set; }
    }
}
