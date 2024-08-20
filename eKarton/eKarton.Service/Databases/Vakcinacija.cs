using System;
using System.Collections.Generic;

namespace eKarton.Service.Databases
{
    public partial class Vakcinacija
    {
        public Vakcinacija()
        {
            PacijentVakcinacijas = new HashSet<PacijentVakcinacija>();
        }

        public int VakcinacijaId { get; set; }
        public string NazivVakcine { get; set; } = null!;

        public virtual ICollection<PacijentVakcinacija> PacijentVakcinacijas { get; set; }
    }
}
