using System;
using System.Collections.Generic;

namespace eKarton.Service.Databases
{
    public partial class Uputnica
    {
        public Uputnica()
        {
            Pregleds = new HashSet<Pregled>();
        }

        public int UputnicaId { get; set; }
        public string Naziv { get; set; } = null!;
        public string Datum { get; set; } = null!;
        public string Razlog { get; set; } = null!;
        public string StateMachine { get; set; } = null!;


        public virtual ICollection<Pregled> Pregleds { get; set; }
    }
}
