using System;
using System.Collections.Generic;

namespace eKarton.Service.Databases
{
    public partial class Pregled
    {
        public int PregledId { get; set; }
        public string Datum { get; set; } = null!;
        public string RazlogPosjete { get; set; } = null!;
        public string Dijagnoza { get; set; } = null!;
        public int TerapijaId { get; set; }
        public int UputnicaId { get; set; }
        public int DoktorId { get; set; }
        public int PacijentId { get; set; }

        public virtual Doktor Doktor { get; set; } = null!;
        public virtual Pacijent Pacijent { get; set; } = null!;
        public virtual Terapija Terapija { get; set; } = null!;
        public virtual Uputnica Uputnica { get; set; } = null!;
    }
}
