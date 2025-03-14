﻿using eKarton.Model.Models;
using System;
using System.Collections.Generic;

namespace eKarton.Service.Databases
{
    public partial class Korisnik
    {
        public Korisnik()
        {
            KorisnikUlogas = new HashSet<KorisnikUloga>();
            Pacijents = new HashSet<Pacijent>();
        }

        public int KorisnikId { get; set; }
        public string Ime { get; set; } = null!;
        public string Prezime { get; set; } = null!;
        public string Spol { get; set; } = null!;
        public string Telefon { get; set; } = null!;
        public string Email { get; set; } = null!;
        public string? DatumRodjenja { get; set; } = null!;
        public string KorisnickoIme { get; set; } = null!;
        public string? LozinkaSalt { get; set; }
        public string? LozinkaHash { get; set; }
        public byte[]? Slika { get; set; }
        //  public int? UlogaId { get; set; }
        //  public virtual Uloga Uloga { get; set; } = null!;
        public virtual ICollection<KorisnikUloga> KorisnikUlogas { get; set; }

        public virtual ICollection<Pacijent> Pacijents { get; set; }
    }
}
