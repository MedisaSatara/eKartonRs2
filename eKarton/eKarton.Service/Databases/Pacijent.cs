using System;
using System.Collections.Generic;

namespace eKarton.Service.Databases
{
    public partial class Pacijent
    {
        public Pacijent()
        {
            DodjeljeniDoktors = new HashSet<DodjeljeniDoktor>();
            Nalazs = new HashSet<Nalaz>();
            PacijentOboljenjas = new HashSet<PacijentOboljenja>();
            PacijentOsiguranjes = new HashSet<PacijentOsiguranje>();
            PacijentVakcinacijas = new HashSet<PacijentVakcinacija>();
            Pregleds = new HashSet<Pregled>();
            PreventivneMjeres = new HashSet<PreventivneMjere>();
            SistematskiPregleds = new HashSet<SistematskiPregled>();
            Termins = new HashSet<Termin>();
        }

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
       /* public string KorisnickoIme { get; set; } = null!;
        public string? LozinkaSalt { get; set; }
        public string? LozinkaHash { get; set; }
        public int KorisnikId { get; set; }

        public virtual Korisnik Korisnik { get; set; } = null!;*/
        public virtual ICollection<DodjeljeniDoktor> DodjeljeniDoktors { get; set; }
        public virtual ICollection<Nalaz> Nalazs { get; set; }
        public virtual ICollection<PacijentOboljenja> PacijentOboljenjas { get; set; }
        public virtual ICollection<PacijentOsiguranje> PacijentOsiguranjes { get; set; }
        public virtual ICollection<PacijentVakcinacija> PacijentVakcinacijas { get; set; }
        public virtual ICollection<Pregled> Pregleds { get; set; }
        public virtual ICollection<PreventivneMjere> PreventivneMjeres { get; set; }
        public virtual ICollection<SistematskiPregled> SistematskiPregleds { get; set; }
        public virtual ICollection<Termin> Termins { get; set; }
    }
}
