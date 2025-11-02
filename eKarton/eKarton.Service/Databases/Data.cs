using eKarton.Service.Databases;
using eKarton.Service.Services;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Services.Database
{
    public static class Data
    {
        public static string GenerateSalt()
        {
            var buf = new byte[16];
            (new RNGCryptoServiceProvider()).GetBytes(buf);
            return Convert.ToBase64String(buf);
        }
        public static string GenerateHash(string salt, string password)
        {
            byte[] src = Convert.FromBase64String(salt);
            byte[] bytes = Encoding.Unicode.GetBytes(password);
            byte[] dst = new byte[src.Length + bytes.Length];

            System.Buffer.BlockCopy(src, 0, dst, 0, src.Length);
            System.Buffer.BlockCopy(bytes, 0, dst, src.Length, bytes.Length);

            HashAlgorithm algorithm = HashAlgorithm.Create("SHA1");
            byte[] inArray = algorithm.ComputeHash(dst);
            return Convert.ToBase64String(inArray);
        }
        public static void Seed(this ModelBuilder modelBuilder)
        {

            List<string> Salt = new List<string>();
            for (int i = 0; i < 5; i++)
            {
                Salt.Add(KorisnikService.GenerateSalt());
            }

            /*for (int i = 0; i < 5; i++)
            {
                Salt.Add(PacijentService.GenerateSalt());
            }*/


            #region Dodavanje Korisnika
            /* modelBuilder.Entity<Korisnik>().HasData(
                    new Korisnik()
                    {
                        KorisnikId = 1001,
                        Ime = "Arijana",
                        Prezime = "Husic",
                        Spol = "Z",
                        Telefon = "063 222 333",
                        Email = "administrator@gmail.com",
                        DatumRodjenja = "1998/11/11",
                        KorisnickoIme = "admin",
                        LozinkaSalt = GenerateSalt(),
                        LozinkaHash = GenerateHash(GenerateSalt(), "test"),
                       // UlogaId=1,

                    },
                     new Korisnik()
                     {
                         KorisnikId = 1002,
                         Ime = "Medisa",
                         Prezime = "Satara",
                         Spol = "Z",
                         Telefon = "063 111 333",
                         Email = "korisnik@gmail.com",
                         DatumRodjenja = "1998/05/07",
                         KorisnickoIme = "korisnik",
                         LozinkaSalt = GenerateSalt(),
                         LozinkaHash = GenerateHash(GenerateSalt(), "korisnik"),
                        // UlogaId =2

                     });*/
            var slikaAdmin = Convert.FromBase64String("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");
            Service.Databases.Korisnik korisnik = new Service.Databases.Korisnik()
            {
                KorisnikId = 1001,
                Ime = "Arijana",
                Prezime = "Husic",
                Spol = "Z",
                Telefon = "063 222 333",
                Email = "administrator@gmail.com",
                DatumRodjenja = "1998/11/11",
                KorisnickoIme = "admin",
                Slika = slikaAdmin


            };
            korisnik.LozinkaSalt = GenerateSalt();
            korisnik.LozinkaHash = GenerateHash(korisnik.LozinkaSalt, "test");
            modelBuilder.Entity<Korisnik>().HasData(korisnik);

            var slikaKorisnik = Convert.FromBase64String("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");
            Service.Databases.Korisnik korisnik2 = new Service.Databases.Korisnik()
            {
                KorisnikId = 1002,
                Ime = "Medisa",
                Prezime = "Satara",
                Spol = "Z",
                Telefon = "063 111 333",
                Email = "korisnik@gmail.com",
                DatumRodjenja = "1998/05/07",
                KorisnickoIme = "korisnik",
                Slika = slikaKorisnik,

            };
            korisnik2.LozinkaSalt = GenerateSalt();
            korisnik2.LozinkaHash = GenerateHash(korisnik2.LozinkaSalt, "test");
            modelBuilder.Entity<Korisnik>().HasData(korisnik2);
            #endregion 

            #region Dodavanje Uloga
            modelBuilder.Entity<Uloga>().HasData(
                 new Uloga()
                 {
                     UlogaId = 1,
                     Naziv = "Admin",
                     OpisUloge = "Upravljanje sistemom"
                 },
                 new Uloga()
                 {
                     UlogaId = 2,
                     Naziv = "Korisnik",
                     OpisUloge = "Pregled podataka"
                 }
                 );
            #endregion

            #region Dodavanje KorisnikUloga
            modelBuilder.Entity<KorisnikUloga>().HasData(
                new KorisnikUloga()
                {
                    KorisnikUlogaId = 1,
                    KorisnikId = 1001,
                    UlogaId = 1,
                    DatumIzmjene = DateTime.Now
                },
                  new KorisnikUloga()
                  {
                      KorisnikUlogaId = 2,
                      KorisnikId = 1002,
                      UlogaId = 2,
                      DatumIzmjene = DateTime.Now
                  });
            #endregion

            #region Dodavanje KategorijaTransakcija25062025
            modelBuilder.Entity<KategorijaTransakcija25062025>().HasData(
                new KategorijaTransakcija25062025()
                {
                    KategorijaTransakcijaId = 5678,
                    NazivKategorije = "Hrana",
                    TipKategorije = "Prihod",
                },
                  new KategorijaTransakcija25062025()
                  {
                      KategorijaTransakcijaId = 5679,
                      NazivKategorije = "Prevoz",
                      TipKategorije = "Prihod",
                  });
            #endregion
            #region Dodavanje Transakcije25062025
            modelBuilder.Entity<Transakcije25062025>().HasData(
                new Transakcije25062025()
                {
                    TransakcijeId=8988,
                    KategorijaTransakcijaId = 5678,
                    KorisnikId=1002,
                    Iznos=200,
                    DatumTransakcije=new DateTime(2025,06,25),
                    Opis="Transkacije racunom",
                    Status="Planirano",
                },
                  new Transakcije25062025()
                  {
                      TransakcijeId = 8989,
                      KategorijaTransakcijaId = 5679,
                      KorisnikId = 1002,
                      Iznos = 500,
                      DatumTransakcije = new DateTime(2025, 06, 15),
                      Opis = "Transkacije racunom",
                      Status = "Planirano",
                  });
            #endregion

            #region Dodavanje Transakcije25062025
            modelBuilder.Entity<TransakcijaLog25062025>().HasData(
                new TransakcijaLog25062025()
                {
                    TransakcijaLogId = 8938,
                    KorisnikId = 1002,
                    TransakcijeId= 8988,
                    StariStatus ="Planirano",
                    NoviStatus="Realizovano",
                    VrijemePromjene=DateTime.Now,


                },
                  new TransakcijaLog25062025()
                  {
                      TransakcijaLogId = 8939,
                      KorisnikId = 1002,
                      TransakcijeId = 8989,
                      StariStatus = "Planirano",
                      NoviStatus = "Otkazano",
                      VrijemePromjene = DateTime.Now,
                  });
            #endregion

            #region Dodavanje Transakcije25062025
            modelBuilder.Entity<FinansijskiLimit250262025>().HasData(
                new FinansijskiLimit250262025()
                {
                    FinansijskiLimitId = 8138,
                    KategorijaTransakcijaId= 5678,
                    IznosLimita = 300,


                });
            #endregion

            #region Podaci Bolnice
            modelBuilder.Entity<Bolnica>().HasData(
                new Bolnica()
                {
                    BolnicaId = 1000,
                    Naziv = "Kantonalna bolnica 'Dr.Safet Mujić'",
                    Adresa = " Maršala Tita 294, Mostar 88000",
                    Email = "bolnica@gmail.com",
                    Telefon = " 036 503-100"
                });
            #endregion

            #region Dodavanje Odjela
            modelBuilder.Entity<Odjel>().HasData(
                new Odjel()
                {
                    OdjelId = 2001,
                    Naziv = "Obiteljska medicina",
                    Telefon = "033/853-222",
                    BolnicaId = 1000

                },
                new Odjel()
                {
                    OdjelId = 2002,
                    Naziv = "Stomatologija",
                    Telefon = "033/853-555",
                    BolnicaId = 1000

                },
                new Odjel()
                {
                    OdjelId = 2003,
                    Naziv = "Neurologija",
                    Telefon = "033/853-552",
                    BolnicaId = 1000

                },
                new Odjel()
                {
                    OdjelId = 2004,
                    Naziv = "Ginekologija",
                    Telefon = "033/853-553",
                    BolnicaId = 1000

                },
                new Odjel()
                {
                    OdjelId = 2005,
                    Naziv = "Psihijatrija",
                    Telefon = "033/853-543",
                    BolnicaId = 1000

                },
                new Odjel()
                {
                    OdjelId = 2006,
                    Naziv = "Pedijatrija",
                    Telefon = "033/853-743",
                    BolnicaId = 1000

                });
            #endregion

            #region Dodavanje Administratora
            modelBuilder.Entity<Administrator>().HasData(
                new Administrator()
                {
                    AdministratorId = 1007,
                    Ime = "Arijana",
                    Prezime = "Husic",
                    DatumRodjenja = "1998/12/16",
                    Telefon = "063 246 022",
                    Email = "arijanahusic@gmail.com",
                    Prebivaliste = "Sarajevo",
                    BolnicaId = 1000
                });
            #endregion

            #region Dodavanje Doktora
            modelBuilder.Entity<Doktor>().HasData(
                new Doktor()
                {
                    DoktorId = 3001,
                    Ime = "STANIJA",
                    Prezime = "TOKMAKČIJA",
                    Spol = "Z",
                    DatumRodjenja = "1998/12/15",
                    Telefon = "063 246 022",
                    Email = "stanija@gmail.com",
                    Grad = "Sarajevo",
                    Jmbg = "1215988789654",
                    //StateMachine = "active",
                    OdjelId = 2001
                },
                new Doktor()
                {
                    DoktorId = 3002,
                    Ime = "Rada",
                    Prezime = "Šandrk",
                    Spol = "Z",
                    DatumRodjenja = "1988-01-02",
                    Telefon = "063 246 722",
                    Email = "radas@gmail.com",
                    Grad = "Mostar",
                    Jmbg = "0102988789654",
                    //StateMachine="active",
                    OdjelId = 2006
                },
                new Doktor()
                {
                    DoktorId = 3003,
                    Ime = "Jelena",
                    Prezime = "Pavlovic",
                    Spol = "Z",
                    DatumRodjenja = "1980-10-02",
                    Telefon = "063 216 722",
                    Email = "jelenap@gmail.com",
                    Grad = "Sarajevo",
                    Jmbg = "1002980789654",
                    //StateMachine = "active",
                    OdjelId = 2006
                },
                 new Doktor()
                 {
                     DoktorId = 3004,
                     Ime = "Marko",
                     Prezime = "Martinac",
                     Spol = "M",
                     DatumRodjenja = "1975-12-09",
                     Telefon = "063 216 722",
                     Email = "markom@gmail.com",
                     Grad = "Sarajevo",
                     Jmbg = "2099750789654",
                    // StateMachine = "active",
                     OdjelId = 2005
                 },
                 new Doktor()
                 {
                     DoktorId = 3005,
                     Ime = "Nada",
                     Prezime = "Bazina",
                     Spol = "Z",
                     DatumRodjenja = "1990 - 07 - 05",
                     Telefon = "062 216 722",
                     Email = "bznada@gmail.com",
                     Grad = "Mostar",
                     Jmbg = "0507990078965",
                    // StateMachine = "archived",
                     OdjelId = 2005
                 },
                 new Doktor()
                 {
                     DoktorId = 3006,
                     Ime = "Adna",
                     Prezime = "Zalihic",
                     Spol = "Z",
                     DatumRodjenja = "1989 - 06 - 28",
                     Telefon = "061 216 722",
                     Email = "adnaz@gmail.com",
                     Grad = "Mostar",
                     Jmbg = "2806989789654",
                     //StateMachine = "draft",
                     OdjelId = 2004
                 },
                 new Doktor()
                 {
                     DoktorId = 3007,
                     Ime = "Ranko",
                     Prezime = "Gacic",
                     Spol = "M",
                     DatumRodjenja = "1980 - 02 - 03",
                     Telefon = "062 317 722",
                     Email = "rankog@gmail.com",
                     Grad = "Tuzla",
                     Jmbg = "2039801236547",
                    // StateMachine = "draft",
                     OdjelId = 2001
                 },
                 new Doktor()
                 {
                     DoktorId = 3008,
                     Ime = "Nikolina",
                     Prezime = "Soce",
                     Spol = "Z",
                     DatumRodjenja = "1970 - 11 - 11",
                     Telefon = "062 216 722",
                     Email = "nikolinas@gmail.com",
                     Grad = "Mostar",
                     Jmbg = "1111197523974",
                    // StateMachine = "cancelled",
                     OdjelId = 2001
                 },
                 new Doktor()
                 {
                     DoktorId = 3009,
                     Ime = "Edita",
                     Prezime = "Sopta",
                     Spol = "Z",
                     DatumRodjenja = "1971 - 03 - 22",
                     Telefon = "062 216 722",
                     Email = "editas@gmail.com",
                     Grad = "Stolac",
                     Jmbg = "2203197154239",
                   //  StateMachine = "active",
                     OdjelId = 2001
                 },
                 new Doktor()
                 {
                     DoktorId = 3010,
                     Ime = "Gordana",
                     Prezime = "Pivic",
                     Spol = "Z",
                     DatumRodjenja = "1971 - 05 - 11",
                     Telefon = "062 216 722",
                     Email = "gordanap@gmail.com",
                     Grad = "Mostar",
                     Jmbg = "1105971289654",
                   //  StateMachine = "active",
                     OdjelId = 2001
                 },
                 new Doktor()
                 {
                     DoktorId = 3011,
                     Ime = "Senad",
                     Prezime = "Vujica",
                     Spol = "M",
                     DatumRodjenja = "1980 - 11 - 19",
                     Telefon = "062 216 722",
                     Email = "senadv@gmail.com",
                     Grad = "Mostar",
                     Jmbg = "1911980647123",
                   //  StateMachine = "archived",
                     OdjelId = 2002
                 },
                 new Doktor()
                 {
                     DoktorId = 3012,
                     Ime = "Sandra",
                     Prezime = "Brajkovic",
                     Spol = "Z",
                     DatumRodjenja = "1985 - 06 - 22",
                     Telefon = "062 216 722",
                     Email = "sandrab@gmail.com",
                     Grad = "Sarajevo",
                     Jmbg = "2206985452136",
                   //  StateMachine = "active",
                     OdjelId = 2003
                 });
            #endregion

            #region Dodavanje Osiguranja
            modelBuilder.Entity<Osiguranje>().HasData(
               new Osiguranje()
               {
                   OsiguranjeId = 4001,
                   Osiguranik = "Intera"
               },
               new Osiguranje()
               {
                   OsiguranjeId = 4002,
                   Osiguranik = "Josip 'Biro'"
               },
               new Osiguranje()
               {
                   OsiguranjeId = 4003,
                   Osiguranik = "Hercegovina promet"
               });
            #endregion

            #region Dodavanje OcjenaDoktora
            modelBuilder.Entity<OcjenaDoktor>().HasData(
                new OcjenaDoktor()
                {
                    OcjenaId = 3100,
                    Ocjena = 4,
                    Razlog = "Vrlo dobar",
                    Anonimno = true,
                    KorisnikId = 1002,
                    DoktorId = 3001
                },
                  new OcjenaDoktor()
                  {
                      OcjenaId = 3200,
                      Ocjena = 5,
                      Razlog = "Odlican",
                      Anonimno = true,
                      KorisnikId = 1002,
                      DoktorId = 3002
                  },
                  new OcjenaDoktor()
                  {
                      OcjenaId = 3300,
                      Ocjena = 4,
                      Razlog = "Vrlo dobar",
                      Anonimno = true,
                      KorisnikId = 1002,
                      DoktorId = 3009
                  },
                                   new OcjenaDoktor()
                                    {
                                        OcjenaId = 3400,
                                        Ocjena = 4,
                                        Razlog = "Vrlo dobar",
                                        Anonimno = true,
                                        KorisnikId = 1002,
                                        DoktorId = 3001
                                    },
                                                      new OcjenaDoktor()
                                                      {
                                                          OcjenaId = 3500,
                                                          Ocjena = 4,
                                                          Razlog = "Vrlo dobar",
                                                          Anonimno = true,
                                                          KorisnikId = 1002,
                                                          DoktorId = 3002
                                                      },
                                                                        new OcjenaDoktor()
                                                                        {
                                                                            OcjenaId = 3600,
                                                                            Ocjena = 4,
                                                                            Razlog = "Vrlo dobar",
                                                                            Anonimno = true,
                                                                            KorisnikId = 1002,
                                                                            DoktorId = 3003
                                                                        },
                                                                                          new OcjenaDoktor()
                                                                                          {
                                                                                              OcjenaId = 3700,
                                                                                              Ocjena = 4,
                                                                                              Razlog = "Vrlo dobar",
                                                                                              Anonimno = true,
                                                                                              KorisnikId = 1002,
                                                                                              DoktorId = 3004
                                                                                          },
                  new OcjenaDoktor()
                  {
                      OcjenaId = 3800,
                      Ocjena = 5,
                      Razlog = "Vrlo dobar",
                      Anonimno = true,
                      KorisnikId = 1002,
                      DoktorId = 3010
                  },
                                    new OcjenaDoktor()
                                    {
                                        OcjenaId = 3900,
                                        Ocjena = 4,
                                        Razlog = "Vrlo dobar",
                                        Anonimno = true,
                                        KorisnikId = 1002,
                                        DoktorId = 3011
                                    },
                                                      new OcjenaDoktor()
                                                      {
                                                          OcjenaId = 3301,
                                                          Ocjena = 3,
                                                          Razlog = "Vrlo dobar",
                                                          Anonimno = true,
                                                          KorisnikId = 1002,
                                                          DoktorId = 3012
                                                      },
                                                                        new OcjenaDoktor()
                                                                        {
                                                                            OcjenaId = 3302,
                                                                            Ocjena = 2,
                                                                            Razlog = "Vrlo dobar",
                                                                            Anonimno = true,
                                                                            KorisnikId = 1002,
                                                                            DoktorId = 3007
                                                                        },
                                                                                          new OcjenaDoktor()
                                                                                          {
                                                                                              OcjenaId = 3303,
                                                                                              Ocjena = 4,
                                                                                              Razlog = "Vrlo dobar",
                                                                                              Anonimno = true,
                                                                                              KorisnikId = 1002,
                                                                                              DoktorId = 3008
                                                                                          },

                  new OcjenaDoktor()
                  {
                      OcjenaId = 3304,
                      Ocjena = 4,
                      Razlog = "Vrlo dobar",
                      Anonimno = true,
                      KorisnikId = 1002,
                      DoktorId = 3006
                  },
                                    new OcjenaDoktor()
                                    {
                                        OcjenaId = 3305,
                                        Ocjena = 4,
                                        Razlog = "Vrlo dobar",
                                        Anonimno = true,
                                        KorisnikId = 1002,
                                        DoktorId = 3005
                                    },
                                     new OcjenaDoktor()
                                     {
                                         OcjenaId = 3306,
                                         Ocjena = 2,
                                         Razlog = "Vrlo dobar",
                                         Anonimno = true,
                                         KorisnikId = 1002,
                                         DoktorId = 3005
                                     },
                                      new OcjenaDoktor()
                                      {
                                          OcjenaId = 3307,
                                          Ocjena = 3,
                                          Razlog = "Vrlo dobar",
                                          Anonimno = true,
                                          KorisnikId = 1002,
                                          DoktorId = 3005
                                      },
                                       new OcjenaDoktor()
                                       {
                                           OcjenaId = 3308,
                                           Ocjena = 5,
                                           Razlog = "Vrlo dobar",
                                           Anonimno = true,
                                           KorisnikId = 1002,
                                           DoktorId = 3005
                                       },
                                        new OcjenaDoktor()
                                        {
                                            OcjenaId = 3309,
                                            Ocjena = 4,
                                            Razlog = "Vrlo dobar",
                                            Anonimno = true,
                                            KorisnikId = 1002,
                                            DoktorId = 3005
                                        },
                                         new OcjenaDoktor()
                                         {
                                             OcjenaId = 3405,
                                             Ocjena = 4,
                                             Razlog = "Vrlo dobar",
                                             Anonimno = true,
                                             KorisnikId = 1002,
                                             DoktorId = 3007
                                         },
                                          new OcjenaDoktor()
                                          {
                                              OcjenaId = 3505,
                                              Ocjena = 4,
                                              Razlog = "Vrlo dobar",
                                              Anonimno = true,
                                              KorisnikId = 1002,
                                              DoktorId = 3007
                                          },
                                           new OcjenaDoktor()
                                           {
                                               OcjenaId = 3605,
                                               Ocjena = 4,
                                               Razlog = "Vrlo dobar",
                                               Anonimno = true,
                                               KorisnikId = 1002,
                                               DoktorId = 3008
                                           },
                                            new OcjenaDoktor()
                                            {
                                                OcjenaId = 3705,
                                                Ocjena = 4,
                                                Razlog = "Vrlo dobar",
                                                Anonimno = true,
                                                KorisnikId = 1002,
                                                DoktorId = 3008
                                            },
                                             new OcjenaDoktor()
                                             {
                                                 OcjenaId = 3709,
                                                 Ocjena = 4,
                                                 Razlog = "Vrlo dobar",
                                                 Anonimno = true,
                                                 KorisnikId = 1002,
                                                 DoktorId = 3009
                                             }
                  );
            #endregion

            #region DodavanjePacijenta

            modelBuilder.Entity<Pacijent>().HasData(
                new Pacijent()
                {
                    PacijentId = 5001,
                    Ime = "Josip",
                    Prezime = "Bojcic",
                    Spol = "M",
                    DatumRodjenja =new DateTime(1998,12,11),
                    Telefon = "061 201 022",
                    MjestoRodjenja = "Mostar",
                    Jmbg = "1211998796541",
                    Prebivaliste = "Mostar",
                    Email = "josip@gmail.com",
                    Koagulopatija = false,
                    KrvnaGrupa = "AB",
                    RhFaktor = "+",
                    HronicneBolesti = "Nema",
                    Alergija = "Ne",
                    BrojKartona = "14B579",
                    /* KorisnickoIme = "pacijent1",
                     LozinkaSalt = Salt[0],
                     LozinkaHash = PacijentService.GenerateHash(Salt[0], "pacijent05"),
                     KorisnikId = 1002*/
                },
                new Pacijent()
                {
                    PacijentId = 5002,
                    Ime = "Helena",
                    Prezime = "Radic",
                    Spol = "Z",
                    DatumRodjenja =new DateTime(1980,05,08),
                    Telefon = "062 201 022",
                    MjestoRodjenja = "Mostar",
                    Jmbg = "5089801236547",
                    Prebivaliste = "Mostar",
                    Email = "helena@gmail.com",
                    Koagulopatija = false,
                    KrvnaGrupa = "A",
                    RhFaktor = "+",
                    HronicneBolesti = "Nema",
                    Alergija = "Antibiotik",
                   // KorisnickoIme = "Pacijent2",
                    BrojKartona = "19378A",
                   /* LozinkaSalt = Salt[0],
                    LozinkaHash = PacijentService.GenerateHash(Salt[0], "pacijent21"),
                    KorisnikId = 1002*/
                },
                new Pacijent()
                {
                    PacijentId = 5003,
                    Ime = "Melita",
                    Prezime = "Golubica",
                    Spol = "Z",
                    DatumRodjenja =new DateTime(1992,11,12),
                    Telefon = "063 991 022",
                    MjestoRodjenja = "Stolac",
                    Jmbg = "5089801236547",
                    Prebivaliste = "Mostar",
                    Email = "melita@gmail.com",
                    Koagulopatija = false,
                    KrvnaGrupa = "AB",
                    RhFaktor = "-",
                    HronicneBolesti = "Nema",
                    Alergija = "Ne",
                   // KorisnickoIme = "pacijent3",
                    BrojKartona = "8537C",
                   /* LozinkaSalt = Salt[0],
                    LozinkaHash = PacijentService.GenerateHash(Salt[0], "pacijent45"),
                    KorisnikId = 1002*/
                });
            #endregion

            #region Dodavanje Dodjeljenog doktora
            modelBuilder.Entity<DodjeljeniDoktor>().HasData(
                new DodjeljeniDoktor()
                {
                    DodjeljeniDoktorId = 3,
                    PacijentId = 5001,
                    DoktorId = 3001,
                    DatumOd = "12.12.2020"
                },
                new DodjeljeniDoktor()
                {
                    DodjeljeniDoktorId = 4,
                    PacijentId = 5002,
                    DoktorId = 3007,
                    DatumOd = "01.10.2021"
                },
                new DodjeljeniDoktor()
                {
                    DodjeljeniDoktorId = 5,
                    PacijentId = 5003,
                    DoktorId = 3008,
                    DatumOd = "22.04.2020"
                });
            #endregion

            #region Dodavanje Osiguranja Pacijenta
            modelBuilder.Entity<PacijentOsiguranje>().HasData(
                new PacijentOsiguranje()
                {
                    PacijentOsiguranjeId = 6,
                    PacijentId = 5001,
                    OsiguranjeId = 4001,
                    DatumOsiguranja = "25.04.2023",
                    Vazece = true

                },
                new PacijentOsiguranje()
                {
                    PacijentOsiguranjeId = 7,
                    PacijentId = 5002,
                    OsiguranjeId = 4002,
                    DatumOsiguranja = "01.05.2023",
                    Vazece = true
                },
                new PacijentOsiguranje()
                {
                    PacijentOsiguranjeId = 8,
                    PacijentId = 5003,
                    OsiguranjeId = 4003,
                    DatumOsiguranja = "30.02.2022",
                    Vazece = true
                });
            #endregion

            #region Dodavanje Terapije
            modelBuilder.Entity<Terapija>().HasData(
                new Terapija()
                {
                    TerapijaId = 6001,
                    NazivLijeka = "Panklav",
                    Uputa = "2 puta na dan",
                    Podsjetnik = "Svako 12 sati",
                    Od = "12.04.2022",
                    Do = "19.04.2022"

                });
            #endregion

            #region Dodavanje Uputnica
            modelBuilder.Entity<Uputnica>().HasData(
                new Uputnica()
                {
                    UputnicaId = 6100,
                    Naziv = "Posjeta orl doktora",
                    Datum = "06.02.2022",
                    Razlog = "Upala uha",
                    StateMachine="arhived"
                },
                                new Uputnica()
                                {
                                    UputnicaId = 6101,
                                    Naziv = "Alergo-test",
                                    Datum = "06.02.2022",
                                    Razlog = "Moguca alergija na odredjene proizvode",
                                    StateMachine="draft"
                                },
                                                new Uputnica()
                                                {
                                                    UputnicaId = 6102,
                                                    Naziv = "CTG",
                                                    Datum = "06.02.2022",
                                                    Razlog = "neki razlog",
                                                    StateMachine="cancelled"
                                                },
                                                                new Uputnica()
                                                                {
                                                                    UputnicaId = 6103,
                                                                    Naziv = "Endoskopija",
                                                                    Datum = "06.02.2022",
                                                                    Razlog = "Bolovi u prsima",
                                                                    StateMachine="active"
                                                                }
                );
            #endregion

            #region Dodavnje Pregleda
            modelBuilder.Entity<Pregled>().HasData(
                new Pregled()
                {
                    PregledId = 6110,
                    RazlogPosjete = "Bol  uhu i glava",
                    Datum = new DateTime(2022, 5, 5),
                    Dijagnoza = "Upala srednjeg uha",
                    TerapijaId = 6001,
                    UputnicaId = 6100,
                    PacijentId = 5001,
                    DoktorId = 3001

                },
                                new Pregled()
                                {
                                    PregledId = 6111,
                                    RazlogPosjete = "Moguca alergijska reakcija",
                                    Datum = new DateTime(2022, 5, 5),
                                    Dijagnoza = "Moguca alergijska reakcija",
                                    TerapijaId = 6001,
                                    UputnicaId = 6101,
                                    PacijentId = 5001,
                                    DoktorId = 3001

                                },
                                                new Pregled()
                                                {
                                                    PregledId = 6112,
                                                    RazlogPosjete = "Bol  uhu i glava",
                                                    Datum = new DateTime(2022, 5, 5),
                                                    Dijagnoza = "Upala srednjeg uha",
                                                    TerapijaId = 6001,
                                                    UputnicaId = 6102,
                                                    PacijentId = 5001,
                                                    DoktorId = 3001

                                                },
                                                                new Pregled()
                                                                {
                                                                    PregledId = 6113,
                                                                    RazlogPosjete = "Otezano kretanje",
                                                                    Datum = new DateTime(2022, 5, 5),
                                                                    Dijagnoza = "Sum na srcu",
                                                                    TerapijaId = 6001,
                                                                    UputnicaId = 6103,
                                                                    PacijentId = 5001,
                                                                    DoktorId = 3001

                                                                }
                );
            #endregion

            #region Dodavnje Termina
            modelBuilder.Entity<Termin>().HasData(
                new Termin()
                {
                    TerminId = 7110,
                    Razlog = "Rutinska kontrola",
                    Datum = "22.05.2022",
                    Vrijeme = "09:15:00",
                    PacijentId = 5001,
                    DoktorId = 3009,
                    StateMachine="active"

                },

                 new Termin()
                 {
                     TerminId = 7116,
                     Razlog = "Rutinska kontrola",
                     Datum = "22.05.2024",
                     Vrijeme = "09:15:00",
                     PacijentId = 5002,
                     DoktorId = 3010,
                     StateMachine = "draft"


                 },

                  new Termin()
                  {
                      TerminId = 7117,
                      Razlog = "Rutinska kontrola",
                      Datum = "15.07.2024",
                      Vrijeme = "09:15:00",
                      PacijentId = 5003,
                      DoktorId = 3007,
                      StateMachine = "canceled"



                  },
                   new Termin()
                   {
                       TerminId = 7118,
                       Razlog = "Rutinska kontrola",
                       Datum = "12.12.2023",
                       Vrijeme = "09:15:00",
                       PacijentId = 5001,
                       DoktorId = 3009,
                       StateMachine = "arhived"


                   },

                                      new Termin()
                                      {
                                          TerminId = 7119,
                                          Razlog = "Rutinska kontrola",
                                          Datum = "11.02.2024",
                                          Vrijeme = "09:15:00",
                                          PacijentId = 5002,
                                          DoktorId = 3007,
                                          StateMachine = "active"


                                      }

                );
            #endregion

            #region Dodavanje Vakcina
            modelBuilder.Entity<Vakcinacija>().HasData(
                new Vakcinacija()
                {
                    VakcinacijaId = 7111,
                    NazivVakcine = "Pfizer"

                });
            #endregion

            #region Dodavanje Vakcinacija
            modelBuilder.Entity<PacijentVakcinacija>().HasData(
                new PacijentVakcinacija()
                {
                    PacijentVakcinacijaId = 9,
                    VakcinacijaId = 7111,
                    PacijentId = 5002,
                    Doza = 2,
                    Datum = "2021-12-22",
                    Lokacija = "Mostar"
                });
            #endregion

            #region Dodavanje Nalaza
            modelBuilder.Entity<Nalaz>().HasData(
               new Nalaz()
               {
                   NalazId = 8001,
                   PacijentId = 5001,
                   LicnaAnamneza = "Upala uha",
                   RadnaAnamneza = "Nema",
                   Datum = "2021-12-22"
               },
               new Nalaz()
               {
                   NalazId = 8002,
                   PacijentId = 5001,
                   LicnaAnamneza = "Ukljesten vrat",
                   RadnaAnamneza = "Nema",
                   Datum = "2021-04-05"
               },
               new Nalaz()
               {
                   NalazId = 8003,
                   PacijentId = 5002,
                   LicnaAnamneza = "Upala pluca",
                   RadnaAnamneza = "Nema",
                   Datum = "2022-03-22"
               },
               new Nalaz()
               {
                   NalazId = 8004,
                   PacijentId = 5003,
                   LicnaAnamneza = "Rutinska kontrola",
                   RadnaAnamneza = "Nema",
                   Datum = "2022-09-01"
               });
            #endregion

            #region Dodavanje Oboljenja
            modelBuilder.Entity<Oboljenje>().HasData(
               new Oboljenje()
               {
                   OboljenjeId = 8010,
                   Dijagnoza = "Dijabetis",
                   Terapija = "Inzulin"
               },
               new Oboljenje()
               {
                   OboljenjeId = 8020,
                   Dijagnoza = "Astma",
                   Terapija = "Pumpica"
               },
                              new Oboljenje()
                              {
                                  OboljenjeId = 8021,
                                  Dijagnoza = "Upala pluca",
                                  Terapija = "Tablete"
                              }
               );
            #endregion

            #region Dodavanje Oboljenja PAcijenta
            modelBuilder.Entity<PacijentOboljenja>().HasData(
               new PacijentOboljenja()
               {
                   PacijentOboljenjaId = 10,
                   OboljenjeId = 8010,
                   PacijentId = 5002,
                   NesposobanZaRad = "Da",
                   NesposobanZaRadOd = "12-05-2022",
                   NesposobanZaRadDo = "12-05-2023"

               },
                              new PacijentOboljenja()
                              {
                                  PacijentOboljenjaId = 11,
                                  OboljenjeId = 8010,
                                  PacijentId = 5001,
                                  NesposobanZaRad = "Ne",
                                  NesposobanZaRadOd = " ",
                                  NesposobanZaRadDo = " "

                              },
                                             new PacijentOboljenja()
                                             {
                                                 PacijentOboljenjaId = 12,
                                                 OboljenjeId = 8020,
                                                 PacijentId = 5001,
                                                 NesposobanZaRad = "Da",
                                                 NesposobanZaRadOd = "12-01-2024",
                                                 NesposobanZaRadDo = "22-02-2024"

                                             },
                                                            new PacijentOboljenja()
                                                            {
                                                                PacijentOboljenjaId = 13,
                                                                OboljenjeId = 8021,
                                                                PacijentId = 5003,
                                                                NesposobanZaRad = "Ne",
                                                                NesposobanZaRadOd = " ",
                                                                NesposobanZaRadDo = " "

                                                            }
               );
            #endregion

            #region Dodavanje Preventivnih mjera
            modelBuilder.Entity<PreventivneMjere>().HasData(
               new PreventivneMjere()
               {
                   PreventivneMjereId = 8111,
                   PacijentId = 5003,
                   Stanje = "Alergijska reakcija"
               });
            #endregion

            #region Dodavanje TehnickePodrske
            modelBuilder.Entity<TehnickaPodrska>().HasData(
                new TehnickaPodrska()
                {
                    TehnickaPodrskaId = 2201,
                    BrojPozivaDoSada = 2,
                    NajcesciProblemi = "problem pri logiranju",
                    BolnicaId = 1000

                },
                new TehnickaPodrska()
                {
                    TehnickaPodrskaId = 2202,
                    BrojPozivaDoSada = 3,
                    NajcesciProblemi = "problem pri zdravstevnom osiguranju",
                    BolnicaId = 1000

                });
            #endregion

         


            //OnModelCreatingPartial(modelBuilder);

        }
    }
}
