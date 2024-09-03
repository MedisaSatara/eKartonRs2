using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Model.Models
{
    public class Pacijent
    {
        public int PacijentId { get; set; }
        public string Ime { get; set; } = null!;
        public string Prezime { get; set; } = null!;
        public string Spol { get; set; } = null!;
        public string? DatumRodjenja { get; set; }
        public string Jmbg { get; set; } = null!;
        public string? MjestoRodjenja { get; set; }
        public string? Prebivaliste { get; set; }
        public string? Email { get; set; }

        public string Telefon { get; set; } = null!;
        public string? KrvnaGrupa { get; set; }
        public string? RhFaktor { get; set; }
        public string? HronicneBolesti { get; set; }
        public string? Alergija { get; set; }
        public bool? Koagulopatija { get; set; }
        public string BrojKartona { get; set; } = null!;
        public int PreventivneMjereId { get; set; }
        /*public string KorisnickoIme { get; set; } = null!;
        public string? Password { get; set; }
        public string? PotvrdaPassworda { get; set; }
        public int KorisnikId { get; set; }*/

        // public virtual Korisnik Korisnik { get; set; } = null!;
        // public virtual ICollection<DodjeljeniDoktor> DodjeljeniDoktors { get; set; }
        // public virtual ICollection<Nalaz> Nalazs { get; set; }
        // public virtual ICollection<PacijentOboljenja> PacijentOboljenjas { get; set; }
        public virtual ICollection<PacijentOsiguranje> PacijentOsiguranjes { get; set; }
        // public virtual ICollection<PacijentVakcinacija> PacijentVakcinacijas { get; set; }
        // public virtual ICollection<Pregled> Pregleds { get; set; }
        public virtual ICollection<PreventivneMjere> PreventivneMjeres { get; set; }
       // public virtual ICollection<SistematskiPregled> SistematskiPregleds { get; set; }
       public virtual ICollection<Termin> Termins { get; set; }
    }
}
