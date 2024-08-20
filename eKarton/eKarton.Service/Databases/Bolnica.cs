using System;
using System.Collections.Generic;

namespace eKarton.Service.Databases
{
    public partial class Bolnica
    {
        public Bolnica()
        {
            Administrators = new HashSet<Administrator>();
            Odjels = new HashSet<Odjel>();
        }

        public int BolnicaId { get; set; }
        public string Naziv { get; set; } = null!;
        public string Adresa { get; set; } = null!;
        public string? Telefon { get; set; }
        public string? Email { get; set; }

        public virtual ICollection<Administrator> Administrators { get; set; }
        public virtual ICollection<Odjel> Odjels { get; set; }
    }
}
