using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Model.Models
{
    public class Korisnik
    {
        public int KorisnikId { get; set; }
        public string Ime { get; set; } = null!;
        public string Prezime { get; set; } = null!;
        public string Spol { get; set; } = null!;
        public string Telefon { get; set; } = null!;
        public string Email { get; set; } = null!;
        public string DatumRodjenja { get; set; } = null!;
        public string KorisnickoIme { get; set; } = null!;
        public string? LozinkaSalt { get; set; }
        public string? LozinkaHash { get; set; }
        public int? UlogaId { get; set; }
        public virtual Uloga Uloga { get; set; } = null!;

        //public virtual ICollection<KorisnikUloga> KorisnikUlogas { get; } = new List<KorisnikUloga>();
        //  public virtual ICollection<Pacijent> Pacijents { get; set; }
    }
}
