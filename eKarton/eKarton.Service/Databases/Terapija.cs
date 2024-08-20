using System;
using System.Collections.Generic;

namespace eKarton.Service.Databases
{
    public partial class Terapija
    {
        public Terapija()
        {
            Pregleds = new HashSet<Pregled>();
        }

        public int TerapijaId { get; set; }
        public string NazivLijeka { get; set; } = null!;
        public string? Uputa { get; set; }
        public string Od { get; set; } = null!;
        public string Do { get; set; } = null!;
        public string? Podsjetnik { get; set; }

        public virtual ICollection<Pregled> Pregleds { get; set; }
    }
}
