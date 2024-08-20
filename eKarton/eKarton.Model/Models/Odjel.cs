using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Model.Models
{
    public class Odjel
    {
        public int OdjelId { get; set; }
        public string Naziv { get; set; } = null!;
        public string? Telefon { get; set; }
        public int BolnicaId { get; set; }

        public virtual Bolnica Bolnica { get; set; } = null!;
        public virtual ICollection<Doktor> Doktors { get; set; }
    }
}
