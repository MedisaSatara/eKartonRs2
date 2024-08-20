using System;
using System.Collections.Generic;

namespace eKarton.Service.Databases
{
    public partial class Odjel
    {
        public Odjel()
        {
            Doktors = new HashSet<Doktor>();
        }

        public int OdjelId { get; set; }
        public string Naziv { get; set; } = null!;
        public string? Telefon { get; set; }
        public int BolnicaId { get; set; }

        public virtual Bolnica Bolnica { get; set; } = null!;
        public virtual ICollection<Doktor> Doktors { get; set; }
    }
}
