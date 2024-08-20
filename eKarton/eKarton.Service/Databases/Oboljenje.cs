using System;
using System.Collections.Generic;

namespace eKarton.Service.Databases
{
    public partial class Oboljenje
    {
        public Oboljenje()
        {
            PacijentOboljenjas = new HashSet<PacijentOboljenja>();
        }

        public int OboljenjeId { get; set; }
        public string? Dijagnoza { get; set; }
        public string? Terapija { get; set; }

        public virtual ICollection<PacijentOboljenja> PacijentOboljenjas { get; set; }
    }
}
