using System;
using System.Collections.Generic;

namespace eKarton.Service.Databases
{
    public partial class Administrator
    {
        public int AdministratorId { get; set; }
        public string Ime { get; set; } = null!;
        public string Prezime { get; set; } = null!;
        public string? DatumRodjenja { get; set; }
        public string? Prebivaliste { get; set; }
        public string? Telefon { get; set; }
        public string Email { get; set; } = null!;
        public int BolnicaId { get; set; }

        public virtual Bolnica Bolnica { get; set; } = null!;
    }
}
