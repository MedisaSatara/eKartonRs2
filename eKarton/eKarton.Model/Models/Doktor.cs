using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Model.Models
{
    public class Doktor
    {
        public int DoktorId { get; set; }
        public string Ime { get; set; } = null!;
        public string Prezime { get; set; } = null!;
        public string? Spol { get; set; }
        public string? DatumRodjenja { get; set; }
        public string? Grad { get; set; }
        public string Jmbg { get; set; } = null!;
        public string? Telefon { get; set; }
        public string? Email { get; set; }
        public int OdjelId { get; set; }

        public virtual Odjel Odjel { get; set; } = null!;
       // public virtual ICollection<DodjeljeniDoktor> DodjeljeniDoktors { get; set; }
       // public virtual ICollection<OcjenaDoktor> OcjenaDoktors { get; set; }
       // public virtual ICollection<Pregled> Pregleds { get; set; }
       // public virtual ICollection<Termin> Termins { get; set; }
    }
}
