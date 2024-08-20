using System;
using System.Collections.Generic;

namespace eKarton.Service.Databases
{
    public partial class OcjenaDoktor
    {
        public int OcjenaId { get; set; }
        public int? Ocjena { get; set; }
        public string? Razlog { get; set; }
        public bool? Anonimno { get; set; }
        public int DoktorId { get; set; }

        public virtual Doktor Doktor { get; set; } = null!;
    }
}
