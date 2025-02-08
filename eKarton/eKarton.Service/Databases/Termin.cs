using System;
using System.Collections.Generic;

namespace eKarton.Service.Databases
{
    public partial class Termin
    {
        public int TerminId { get; set; }
        public string Datum { get; set; } = null!;
        public string Vrijeme { get; set; } = null!;
        public string? Razlog { get; set; }
        public int PacijentId { get; set; }
        public int DoktorId { get; set; }

        public virtual Doktor Doktor { get; set; } = null!;
        public virtual Pacijent Pacijent { get; set; } = null!;
        public string? StateMachine { get; set; }
        public double? CijenaPregleda { get; set; }
        public string? brojTransakcije { get; set; }


    }
}
