using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Model.Models
{
    public class Bolnica
    {

        public int BolnicaId { get; set; }
        public string Naziv { get; set; } = null!;
        public string Adresa { get; set; } = null!;
        public string? Telefon { get; set; }
        public string? Email { get; set; }

        public virtual ICollection<Administrator> Administrators { get; set; }
       // public virtual ICollection<Odjel> Odjels { get; set; }
    }
}
