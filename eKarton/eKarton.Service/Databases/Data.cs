using eKarton.Service.Databases;
using eKarton.Service.Services;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Services.Database
{
    public static class Data
    {
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
            modelBuilder.Entity<Korisnik>().HasData(
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
                       LozinkaSalt = Salt[1],
                       LozinkaHash = PacijentService.GenerateHash(Salt[1], "admin"),
                       UlogaId=1,

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
                        LozinkaSalt = Salt[2],
                        LozinkaHash = PacijentService.GenerateHash(Salt[2], "korisnik"),
                        UlogaId=2

                    });
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
            /*modelBuilder.Entity<KorisnikUloga>().HasData(
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
                  });*/
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
                    StateMachine = "active",
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
                    StateMachine="active",
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
                    StateMachine = "active",
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
                     StateMachine = "active",
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
                     StateMachine = "archived",
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
                     StateMachine = "draft",
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
                     StateMachine = "draft",
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
                     StateMachine = "cancelled",
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
                     StateMachine = "active",
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
                     StateMachine = "active",
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
                     StateMachine = "archived",
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
                     StateMachine = "active",
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
                    KorisnikId=1002,
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
                                                                                              Ocjena = 8,
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
                    DatumRodjenja = "1998-12-11",
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
                    DatumRodjenja = "1980-05-08",
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
                    DatumRodjenja = "1992-11-12",
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
                    Datum = "05.05.2022",
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
                                    Datum = "05.05.2022",
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
                                                    Datum = "05.05.2022",
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
                                                                    Datum = "05.05.2022",
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
                    Razlog = "rutinska kontrola",
                    Datum = "22.05.2022",
                    Vrijeme = "09:15:00",
                    PacijentId = 5001,
                    DoktorId = 3009

                });
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
               });
            #endregion

            #region Dodavanje Oboljenja PAcijenta
            modelBuilder.Entity<PacijentOboljenja>().HasData(
               new PacijentOboljenja()
               {
                   PacijentOboljenjaId = 10,
                   OboljenjeId = 8010,
                   PacijentId = 5002,
                   NesposobanZaRad = "Ne",
                   NesposobanZaRadOd = " ",
                   NesposobanZaRadDo = " "
               });
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



            //OnModelCreatingPartial(modelBuilder);

        }
    }
}
