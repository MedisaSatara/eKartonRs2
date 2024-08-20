using System;
using System.Collections.Generic;

namespace eKarton.Service.Databases
{
    public partial class PacijentVakcinacija
    {
        public int PacijentVakcinacijaId { get; set; }
        public int? PacijentId { get; set; }
        public int? VakcinacijaId { get; set; }
        public int? Doza { get; set; }
        public string? Datum { get; set; }
        public string? Lokacija { get; set; }

        public virtual Pacijent? Pacijent { get; set; }
        public virtual Vakcinacija? Vakcinacija { get; set; }
    }
}
