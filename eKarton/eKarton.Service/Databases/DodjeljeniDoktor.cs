using System;
using System.Collections.Generic;

namespace eKarton.Service.Databases
{
    public partial class DodjeljeniDoktor
    {
        public int DodjeljeniDoktorId { get; set; }
        public int DoktorId { get; set; }
        public int PacijentId { get; set; }
        public string? DatumOd { get; set; }

        public virtual Doktor Doktor { get; set; } = null!;
        public virtual Pacijent Pacijent { get; set; } = null!;
    }
}
