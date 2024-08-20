using System;
using System.Collections.Generic;

namespace eKarton.Service.Databases
{
    public partial class Nalaz
    {
        public int NalazId { get; set; }
        public string? Datum { get; set; }
        public string? LicnaAnamneza { get; set; }
        public string? RadnaAnamneza { get; set; }
        public int PacijentId { get; set; }

        public virtual Pacijent Pacijent { get; set; } = null!;
    }
}
