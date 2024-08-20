using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eKarton.Service.Migrations
{
    public partial class initial : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Bolnica",
                columns: table => new
                {
                    BolnicaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    Adresa = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Telefon = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: true),
                    Email = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Bolnica", x => x.BolnicaId);
                });

            migrationBuilder.CreateTable(
                name: "Korisnik",
                columns: table => new
                {
                    KorisnikId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Ime = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: false),
                    Prezime = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: false),
                    KorisnickoIme = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    LozinkaSalt = table.Column<string>(type: "nvarchar(250)", maxLength: 250, nullable: true),
                    LozinkaHash = table.Column<string>(type: "nvarchar(250)", maxLength: 250, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Korisnik", x => x.KorisnikId);
                });

            migrationBuilder.CreateTable(
                name: "Oboljenje",
                columns: table => new
                {
                    OboljenjeId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Dijagnoza = table.Column<string>(type: "nvarchar(250)", maxLength: 250, nullable: true),
                    Terapija = table.Column<string>(type: "nvarchar(250)", maxLength: 250, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Oboljenje", x => x.OboljenjeId);
                });

            migrationBuilder.CreateTable(
                name: "Osiguranje",
                columns: table => new
                {
                    OsiguranjeId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Osiguranik = table.Column<string>(type: "nvarchar(250)", maxLength: 250, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Osiguranje", x => x.OsiguranjeId);
                });

            migrationBuilder.CreateTable(
                name: "Terapija",
                columns: table => new
                {
                    TerapijaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    NazivLijeka = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    Uputa = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: true),
                    Od = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    Do = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    Podsjetnik = table.Column<string>(type: "nvarchar(250)", maxLength: 250, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Terapija", x => x.TerapijaId);
                });

            migrationBuilder.CreateTable(
                name: "Uloga",
                columns: table => new
                {
                    UlogaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    OpisUloge = table.Column<string>(type: "nvarchar(250)", maxLength: 250, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Uloga", x => x.UlogaId);
                });

            migrationBuilder.CreateTable(
                name: "Uputnica",
                columns: table => new
                {
                    UputnicaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(250)", maxLength: 250, nullable: false),
                    Datum = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    Razlog = table.Column<string>(type: "nvarchar(250)", maxLength: 250, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Uputnica", x => x.UputnicaId);
                });

            migrationBuilder.CreateTable(
                name: "Vakcinacija",
                columns: table => new
                {
                    VakcinacijaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    NazivVakcine = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Vakcinacija", x => x.VakcinacijaId);
                });

            migrationBuilder.CreateTable(
                name: "Administrator",
                columns: table => new
                {
                    AdministratorId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Ime = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: false),
                    Prezime = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: false),
                    DatumRodjenja = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: true),
                    Prebivaliste = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    Telefon = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: true),
                    Email = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    BolnicaId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Administrator", x => x.AdministratorId);
                    table.ForeignKey(
                        name: "FK_Bolnica_Administrator",
                        column: x => x.BolnicaId,
                        principalTable: "Bolnica",
                        principalColumn: "BolnicaId");
                });

            migrationBuilder.CreateTable(
                name: "Odjel",
                columns: table => new
                {
                    OdjelId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    Telefon = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: true),
                    BolnicaId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Odjel", x => x.OdjelId);
                    table.ForeignKey(
                        name: "FK_Bolnica_Odjel",
                        column: x => x.BolnicaId,
                        principalTable: "Bolnica",
                        principalColumn: "BolnicaId");
                });

            migrationBuilder.CreateTable(
                name: "Pacijent",
                columns: table => new
                {
                    PacijentId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Ime = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: false),
                    Prezime = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: false),
                    Spol = table.Column<string>(type: "nvarchar(1)", maxLength: 1, nullable: false),
                    DatumRodjenja = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: true),
                    JMBG = table.Column<string>(type: "nvarchar(13)", maxLength: 13, nullable: false),
                    MjestoRodjenja = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    Prebivaliste = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    Telefon = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    KrvnaGrupa = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: true),
                    RhFaktor = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: true),
                    HronicneBolesti = table.Column<string>(type: "nvarchar(250)", maxLength: 250, nullable: true),
                    Alergija = table.Column<string>(type: "nvarchar(250)", maxLength: 250, nullable: true),
                    Koagulopatija = table.Column<bool>(type: "bit", nullable: true),
                    BrojKartona = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: false),
                    KorisnickoIme = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    LozinkaSalt = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    LozinkaHash = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    KorisnikId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Pacijent", x => x.PacijentId);
                    table.ForeignKey(
                        name: "FK_Korisnik_Pacijent",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnik",
                        principalColumn: "KorisnikId");
                });

            migrationBuilder.CreateTable(
                name: "KorisnikUloga",
                columns: table => new
                {
                    KorisnikUlogaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KorisnikId = table.Column<int>(type: "int", nullable: true),
                    UlogaId = table.Column<int>(type: "int", nullable: true),
                    DatumIzmjene = table.Column<DateTime>(type: "date", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_KorisnikUloga", x => x.KorisnikUlogaId);
                    table.ForeignKey(
                        name: "FK_Korisnik_KorisnikUloga",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnik",
                        principalColumn: "KorisnikId");
                    table.ForeignKey(
                        name: "FK_Uloga_KorisnikUloga",
                        column: x => x.UlogaId,
                        principalTable: "Uloga",
                        principalColumn: "UlogaId");
                });

            migrationBuilder.CreateTable(
                name: "Doktor",
                columns: table => new
                {
                    DoktorId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Ime = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: false),
                    Prezime = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: false),
                    Spol = table.Column<string>(type: "nvarchar(1)", maxLength: 1, nullable: true),
                    DatumRodjenja = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: true),
                    Grad = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: true),
                    JMBG = table.Column<string>(type: "nvarchar(13)", maxLength: 13, nullable: false),
                    Telefon = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: true),
                    Email = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    OdjelId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Doktor", x => x.DoktorId);
                    table.ForeignKey(
                        name: "FK_Odjel_Doktor",
                        column: x => x.OdjelId,
                        principalTable: "Odjel",
                        principalColumn: "OdjelId");
                });

            migrationBuilder.CreateTable(
                name: "Nalaz",
                columns: table => new
                {
                    NalazId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Datum = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: true),
                    LicnaAnamneza = table.Column<string>(type: "nvarchar(250)", maxLength: 250, nullable: true),
                    RadnaAnamneza = table.Column<string>(type: "nvarchar(250)", maxLength: 250, nullable: true),
                    PacijentId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Nalaz", x => x.NalazId);
                    table.ForeignKey(
                        name: "FK_Nalaz_Pacijent",
                        column: x => x.PacijentId,
                        principalTable: "Pacijent",
                        principalColumn: "PacijentId");
                });

            migrationBuilder.CreateTable(
                name: "PacijentOboljenja",
                columns: table => new
                {
                    PacijentOboljenjaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    OboljenjeId = table.Column<int>(type: "int", nullable: true),
                    PacijentId = table.Column<int>(type: "int", nullable: true),
                    NesposobanZaRad = table.Column<string>(type: "nvarchar(250)", maxLength: 250, nullable: true),
                    NesposobanZaRadOd = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: true),
                    NesposobanZaRadDo = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PacijentOboljenja", x => x.PacijentOboljenjaId);
                    table.ForeignKey(
                        name: "FK_Oboljenje_PacijentOboljenja",
                        column: x => x.OboljenjeId,
                        principalTable: "Oboljenje",
                        principalColumn: "OboljenjeId");
                    table.ForeignKey(
                        name: "FK_Pacijent_PacijentOboljenja",
                        column: x => x.PacijentId,
                        principalTable: "Pacijent",
                        principalColumn: "PacijentId");
                });

            migrationBuilder.CreateTable(
                name: "PacijentOsiguranje",
                columns: table => new
                {
                    PacijentOsiguranjeId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    PacijentId = table.Column<int>(type: "int", nullable: true),
                    OsiguranjeId = table.Column<int>(type: "int", nullable: true),
                    DatumOsiguranja = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: true),
                    Vazece = table.Column<bool>(type: "bit", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PacijentOsiguranje", x => x.PacijentOsiguranjeId);
                    table.ForeignKey(
                        name: "FK_Osiguranje_PacijentOsiguranje",
                        column: x => x.OsiguranjeId,
                        principalTable: "Osiguranje",
                        principalColumn: "OsiguranjeId");
                    table.ForeignKey(
                        name: "FK_Pacijent_PacijentOsiguranje",
                        column: x => x.PacijentId,
                        principalTable: "Pacijent",
                        principalColumn: "PacijentId");
                });

            migrationBuilder.CreateTable(
                name: "PacijentVakcinacija",
                columns: table => new
                {
                    PacijentVakcinacijaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    PacijentId = table.Column<int>(type: "int", nullable: true),
                    VakcinacijaId = table.Column<int>(type: "int", nullable: true),
                    Doza = table.Column<int>(type: "int", nullable: true),
                    Datum = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: true),
                    Lokacija = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PacijentVakcinacija", x => x.PacijentVakcinacijaId);
                    table.ForeignKey(
                        name: "FK_Pacijent_PacijentVakcinacija",
                        column: x => x.PacijentId,
                        principalTable: "Pacijent",
                        principalColumn: "PacijentId");
                    table.ForeignKey(
                        name: "FK_Vakcinacija_PacijentVakcinacija",
                        column: x => x.VakcinacijaId,
                        principalTable: "Vakcinacija",
                        principalColumn: "VakcinacijaId");
                });

            migrationBuilder.CreateTable(
                name: "PreventivneMjere",
                columns: table => new
                {
                    PreventivneMjereId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Stanje = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    PacijentId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PreventivneMjere", x => x.PreventivneMjereId);
                    table.ForeignKey(
                        name: "FK_Pacijent_Mjere",
                        column: x => x.PacijentId,
                        principalTable: "Pacijent",
                        principalColumn: "PacijentId");
                });

            migrationBuilder.CreateTable(
                name: "SistematskiPregled",
                columns: table => new
                {
                    SistematskiPregledId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Datum = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    Visina = table.Column<decimal>(type: "decimal(10,2)", nullable: false),
                    Tezina = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: false),
                    ObimGrudi = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    ObimStruka = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    BMI = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    KrvniPritisak = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    Puls = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    PromjenaNaKozi = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Ekstremiteti = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Cula = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Tonzile = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Vrat = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    GrudniKos = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Pluca = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Abdomen = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    KicmeniStub = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    PacijentId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_SistematskiPregled", x => x.SistematskiPregledId);
                    table.ForeignKey(
                        name: "FK_Pacijent_SistematskiPregled",
                        column: x => x.PacijentId,
                        principalTable: "Pacijent",
                        principalColumn: "PacijentId");
                });

            migrationBuilder.CreateTable(
                name: "DodjeljeniDoktor",
                columns: table => new
                {
                    DodjeljeniDoktorId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    DoktorId = table.Column<int>(type: "int", nullable: false),
                    PacijentId = table.Column<int>(type: "int", nullable: false),
                    DatumOd = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DodjeljeniDoktor", x => x.DodjeljeniDoktorId);
                    table.ForeignKey(
                        name: "FK_Doktor_DodjeljeniDoktor",
                        column: x => x.DoktorId,
                        principalTable: "Doktor",
                        principalColumn: "DoktorId");
                    table.ForeignKey(
                        name: "FK_Pacijent_DodjeljeniDoktor",
                        column: x => x.PacijentId,
                        principalTable: "Pacijent",
                        principalColumn: "PacijentId");
                });

            migrationBuilder.CreateTable(
                name: "OcjenaDoktor",
                columns: table => new
                {
                    OcjenaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Ocjena = table.Column<int>(type: "int", nullable: true),
                    Razlog = table.Column<string>(type: "nvarchar(250)", maxLength: 250, nullable: true),
                    Anonimno = table.Column<bool>(type: "bit", nullable: true),
                    DoktorId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__OcjenaDo__E6FC7AA90F43BF09", x => x.OcjenaId);
                    table.ForeignKey(
                        name: "FK_Doktor_OcjenaDoktor",
                        column: x => x.DoktorId,
                        principalTable: "Doktor",
                        principalColumn: "DoktorId");
                });

            migrationBuilder.CreateTable(
                name: "Pregled",
                columns: table => new
                {
                    PregledId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Datum = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    RazlogPosjete = table.Column<string>(type: "nvarchar(250)", maxLength: 250, nullable: false),
                    Dijagnoza = table.Column<string>(type: "nvarchar(250)", maxLength: 250, nullable: false),
                    TerapijaId = table.Column<int>(type: "int", nullable: false),
                    UputnicaId = table.Column<int>(type: "int", nullable: false),
                    DoktorId = table.Column<int>(type: "int", nullable: false),
                    PacijentId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Pregled", x => x.PregledId);
                    table.ForeignKey(
                        name: "FK_Doktor_Pregled",
                        column: x => x.DoktorId,
                        principalTable: "Doktor",
                        principalColumn: "DoktorId");
                    table.ForeignKey(
                        name: "FK_Pacijent_Pregled",
                        column: x => x.PacijentId,
                        principalTable: "Pacijent",
                        principalColumn: "PacijentId");
                    table.ForeignKey(
                        name: "FK_Terapija_Pregled",
                        column: x => x.TerapijaId,
                        principalTable: "Terapija",
                        principalColumn: "TerapijaId");
                    table.ForeignKey(
                        name: "FK_Uputnica_Pregled",
                        column: x => x.UputnicaId,
                        principalTable: "Uputnica",
                        principalColumn: "UputnicaId");
                });

            migrationBuilder.CreateTable(
                name: "Termin",
                columns: table => new
                {
                    TerminId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Datum = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    Vrijeme = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    Razlog = table.Column<string>(type: "nvarchar(250)", maxLength: 250, nullable: true),
                    PacijentId = table.Column<int>(type: "int", nullable: false),
                    DoktorId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Termin", x => x.TerminId);
                    table.ForeignKey(
                        name: "FK_Doktor_Termin",
                        column: x => x.DoktorId,
                        principalTable: "Doktor",
                        principalColumn: "DoktorId");
                    table.ForeignKey(
                        name: "FK_Pacijent_Termin",
                        column: x => x.PacijentId,
                        principalTable: "Pacijent",
                        principalColumn: "PacijentId");
                });

            migrationBuilder.InsertData(
                table: "Bolnica",
                columns: new[] { "BolnicaId", "Adresa", "Email", "Naziv", "Telefon" },
                values: new object[] { 1000, " Maršala Tita 294, Mostar 88000", "bolnica@gmail.com", "Kantonalna bolnica 'Dr.Safet Mujić'", " 036 503-100" });

            migrationBuilder.InsertData(
                table: "Korisnik",
                columns: new[] { "KorisnikId", "Ime", "KorisnickoIme", "LozinkaHash", "LozinkaSalt", "Prezime" },
                values: new object[,]
                {
                    { 1001, "Arijana", "admin", "T7EASKk+28QKkDvtIqvbJ5cdnqM=", "bkd151t0IwAXqJTEMvArOw==", "Husic" },
                    { 1002, "Medisa", "korisnik", "rJ/ML1Fsx5yRLiWSdKKDkAptjuo=", "EtXJ7lV6p6Ku3IHXSszasg==", "Satara" }
                });

            migrationBuilder.InsertData(
                table: "Oboljenje",
                columns: new[] { "OboljenjeId", "Dijagnoza", "Terapija" },
                values: new object[,]
                {
                    { 8010, "Dijabetis", "Inzulin" },
                    { 8020, "Astma", "Pumpica" }
                });

            migrationBuilder.InsertData(
                table: "Osiguranje",
                columns: new[] { "OsiguranjeId", "Osiguranik" },
                values: new object[,]
                {
                    { 4001, "Intera" },
                    { 4002, "Josip 'Biro'" },
                    { 4003, "Hercegovina promet" }
                });

            migrationBuilder.InsertData(
                table: "Terapija",
                columns: new[] { "TerapijaId", "Do", "NazivLijeka", "Od", "Podsjetnik", "Uputa" },
                values: new object[] { 6001, "19.04.2022", "Panklav", "12.04.2022", "Svako 12 sati", "2 puta na dan" });

            migrationBuilder.InsertData(
                table: "Uloga",
                columns: new[] { "UlogaId", "Naziv", "OpisUloge" },
                values: new object[,]
                {
                    { 1, "Admin", "Upravljanje sistemom" },
                    { 2, "Korisnik", "Pregled podataka" }
                });

            migrationBuilder.InsertData(
                table: "Uputnica",
                columns: new[] { "UputnicaId", "Datum", "Naziv", "Razlog" },
                values: new object[] { 6100, "06.02.2022", "Posjeta orl doktora", "Upala uha" });

            migrationBuilder.InsertData(
                table: "Vakcinacija",
                columns: new[] { "VakcinacijaId", "NazivVakcine" },
                values: new object[] { 7111, "Pfizer" });

            migrationBuilder.InsertData(
                table: "Administrator",
                columns: new[] { "AdministratorId", "BolnicaId", "DatumRodjenja", "Email", "Ime", "Prebivaliste", "Prezime", "Telefon" },
                values: new object[] { 1007, 1000, "1998/12/16", "arijanahusic@gmail.com", "Arijana", "Sarajevo", "Husic", "063 246 022" });

            migrationBuilder.InsertData(
                table: "KorisnikUloga",
                columns: new[] { "KorisnikUlogaId", "DatumIzmjene", "KorisnikId", "UlogaId" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 8, 18, 21, 6, 4, 316, DateTimeKind.Local).AddTicks(9213), 1001, 1 },
                    { 2, new DateTime(2024, 8, 18, 21, 6, 4, 316, DateTimeKind.Local).AddTicks(9318), 1002, 2 }
                });

            migrationBuilder.InsertData(
                table: "Odjel",
                columns: new[] { "OdjelId", "BolnicaId", "Naziv", "Telefon" },
                values: new object[,]
                {
                    { 2001, 1000, "Obiteljska medicina", "033/853-222" },
                    { 2002, 1000, "Stomatologija", "033/853-555" },
                    { 2003, 1000, "Neurologija", "033/853-552" },
                    { 2004, 1000, "Ginekologija", "033/853-553" },
                    { 2005, 1000, "Psihijatrija", "033/853-543" },
                    { 2006, 1000, "Pedijatrija", "033/853-743" }
                });

            migrationBuilder.InsertData(
                table: "Pacijent",
                columns: new[] { "PacijentId", "Alergija", "BrojKartona", "DatumRodjenja", "HronicneBolesti", "Ime", "JMBG", "Koagulopatija", "KorisnickoIme", "KorisnikId", "KrvnaGrupa", "LozinkaHash", "LozinkaSalt", "MjestoRodjenja", "Prebivaliste", "Prezime", "RhFaktor", "Spol", "Telefon" },
                values: new object[,]
                {
                    { 5001, "Ne", "14B579", "1998-12-11", "Nema", "Josip", "1211998796541", false, "pacijent1", 1002, "AB", "mwDa5Wdz2U+bTWEalAISh8aZhb8=", "Cf4+pxGPEziGdsuI7+bO4w==", "Mostar", "Mostar", "Bojcic", "+", "M", "061 201 022" },
                    { 5002, "Antibiotik", "19378A", "1980-05-08", "Nema", "Helena", "5089801236547", false, "Pacijent2", 1002, "A", "OAEErK375loaBm3yY3RsoX68rqM=", "Cf4+pxGPEziGdsuI7+bO4w==", "Mostar", "Mostar", "Radic", "+", "Z", "062 201 022" },
                    { 5003, "Ne", "8537C", "1992-11-12", "Nema", "Melita", "5089801236547", false, "pacijent3", 1002, "AB", "hPXetNrw+UshgufuekRrxRgFflc=", "Cf4+pxGPEziGdsuI7+bO4w==", "Stolac", "Mostar", "Golubica", "-", "Z", "063 991 022" }
                });

            migrationBuilder.InsertData(
                table: "Doktor",
                columns: new[] { "DoktorId", "DatumRodjenja", "Email", "Grad", "Ime", "JMBG", "OdjelId", "Prezime", "Spol", "Telefon" },
                values: new object[,]
                {
                    { 3001, "1998/12/15", "stanija@gmail.com", "Sarajevo", "STANIJA", "1215988789654", 2001, "TOKMAKČIJA", "Z", "063 246 022" },
                    { 3002, "1988-01-02", "radas@gmail.com", "Mostar", "Rada", "0102988789654", 2006, "Šandrk", "Z", "063 246 722" },
                    { 3003, "1980-10-02", "jelenap@gmail.com", "Sarajevo", "Jelena", "1002980789654", 2006, "Pavlovic", "Z", "063 216 722" },
                    { 3004, "1975-12-09", "markom@gmail.com", "Sarajevo", "Marko", "2099750789654", 2005, "Martinac", "M", "063 216 722" },
                    { 3005, "1990 - 07 - 05", "bznada@gmail.com", "Mostar", "Nada", "0507990078965", 2005, "Bazina", "Z", "062 216 722" },
                    { 3006, "1989 - 06 - 28", "adnaz@gmail.com", "Mostar", "Adna", "2806989789654", 2004, "Zalihic", "Z", "061 216 722" },
                    { 3007, "1980 - 02 - 03", "rankog@gmail.com", "Tuzla", "Ranko", "2039801236547", 2001, "Gacic", "M", "062 317 722" },
                    { 3008, "1970 - 11 - 11", "nikolinas@gmail.com", "Mostar", "Nikolina", "1111197523974", 2001, "Soce", "Z", "062 216 722" },
                    { 3009, "1971 - 03 - 22", "editas@gmail.com", "Stolac", "Edita", "2203197154239", 2001, "Sopta", "Z", "062 216 722" },
                    { 3010, "1971 - 05 - 11", "gordanap@gmail.com", "Mostar", "Gordana", "1105971289654", 2001, "Pivic", "Z", "062 216 722" },
                    { 3011, "1980 - 11 - 19", "senadv@gmail.com", "Mostar", "Senad", "1911980647123", 2002, "Vujica", "M", "062 216 722" },
                    { 3012, "1985 - 06 - 22", "sandrab@gmail.com", "Sarajevo", "Sandra", "2206985452136", 2003, "Brajkovic", "Z", "062 216 722" }
                });

            migrationBuilder.InsertData(
                table: "Nalaz",
                columns: new[] { "NalazId", "Datum", "LicnaAnamneza", "PacijentId", "RadnaAnamneza" },
                values: new object[,]
                {
                    { 8001, "2021-12-22", "Upala uha", 5001, "Nema" },
                    { 8002, "2021-04-05", "Ukljesten vrat", 5001, "Nema" },
                    { 8003, "2022-03-22", "Upala pluca", 5002, "Nema" },
                    { 8004, "2022-09-01", "Rutinska kontrola", 5003, "Nema" }
                });

            migrationBuilder.InsertData(
                table: "PacijentOboljenja",
                columns: new[] { "PacijentOboljenjaId", "NesposobanZaRad", "NesposobanZaRadDo", "NesposobanZaRadOd", "OboljenjeId", "PacijentId" },
                values: new object[] { 10, "Ne", " ", " ", 8010, 5002 });

            migrationBuilder.InsertData(
                table: "PacijentOsiguranje",
                columns: new[] { "PacijentOsiguranjeId", "DatumOsiguranja", "OsiguranjeId", "PacijentId", "Vazece" },
                values: new object[,]
                {
                    { 6, "25.04.2023", 4001, 5001, true },
                    { 7, "01.05.2023", 4002, 5002, true },
                    { 8, "30.02.2022", 4003, 5003, true }
                });

            migrationBuilder.InsertData(
                table: "PacijentVakcinacija",
                columns: new[] { "PacijentVakcinacijaId", "Datum", "Doza", "Lokacija", "PacijentId", "VakcinacijaId" },
                values: new object[] { 9, "2021-12-22", 2, "Mostar", 5002, 7111 });

            migrationBuilder.InsertData(
                table: "PreventivneMjere",
                columns: new[] { "PreventivneMjereId", "PacijentId", "Stanje" },
                values: new object[] { 8111, 5003, "Alergijska reakcija" });

            migrationBuilder.InsertData(
                table: "DodjeljeniDoktor",
                columns: new[] { "DodjeljeniDoktorId", "DatumOd", "DoktorId", "PacijentId" },
                values: new object[,]
                {
                    { 3, "12.12.2020", 3001, 5001 },
                    { 4, "01.10.2021", 3007, 5002 },
                    { 5, "22.04.2020", 3008, 5003 }
                });

            migrationBuilder.InsertData(
                table: "OcjenaDoktor",
                columns: new[] { "OcjenaId", "Anonimno", "DoktorId", "Ocjena", "Razlog" },
                values: new object[,]
                {
                    { 3100, true, 3001, 4, "Vrlo dobar" },
                    { 3200, true, 3002, 5, "Odlican" },
                    { 3300, true, 3009, 4, "Vrlo dobar" }
                });

            migrationBuilder.InsertData(
                table: "Pregled",
                columns: new[] { "PregledId", "Datum", "Dijagnoza", "DoktorId", "PacijentId", "RazlogPosjete", "TerapijaId", "UputnicaId" },
                values: new object[] { 6110, "05.05.2022", "Upala srednjeg uha", 3001, 5001, "Bol  uhu i glava", 6001, 6100 });

            migrationBuilder.InsertData(
                table: "Termin",
                columns: new[] { "TerminId", "Datum", "DoktorId", "PacijentId", "Razlog", "Vrijeme" },
                values: new object[] { 7110, "22.05.2022", 3009, 5001, "rutinska kontrola", "09:15:00" });

            migrationBuilder.CreateIndex(
                name: "IX_Administrator_BolnicaId",
                table: "Administrator",
                column: "BolnicaId");

            migrationBuilder.CreateIndex(
                name: "IX_DodjeljeniDoktor_DoktorId",
                table: "DodjeljeniDoktor",
                column: "DoktorId");

            migrationBuilder.CreateIndex(
                name: "IX_DodjeljeniDoktor_PacijentId",
                table: "DodjeljeniDoktor",
                column: "PacijentId");

            migrationBuilder.CreateIndex(
                name: "IX_Doktor_OdjelId",
                table: "Doktor",
                column: "OdjelId");

            migrationBuilder.CreateIndex(
                name: "IX_KorisnikUloga_KorisnikId",
                table: "KorisnikUloga",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_KorisnikUloga_UlogaId",
                table: "KorisnikUloga",
                column: "UlogaId");

            migrationBuilder.CreateIndex(
                name: "IX_Nalaz_PacijentId",
                table: "Nalaz",
                column: "PacijentId");

            migrationBuilder.CreateIndex(
                name: "IX_OcjenaDoktor_DoktorId",
                table: "OcjenaDoktor",
                column: "DoktorId");

            migrationBuilder.CreateIndex(
                name: "IX_Odjel_BolnicaId",
                table: "Odjel",
                column: "BolnicaId");

            migrationBuilder.CreateIndex(
                name: "IX_Pacijent_KorisnikId",
                table: "Pacijent",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_PacijentOboljenja_OboljenjeId",
                table: "PacijentOboljenja",
                column: "OboljenjeId");

            migrationBuilder.CreateIndex(
                name: "IX_PacijentOboljenja_PacijentId",
                table: "PacijentOboljenja",
                column: "PacijentId");

            migrationBuilder.CreateIndex(
                name: "IX_PacijentOsiguranje_OsiguranjeId",
                table: "PacijentOsiguranje",
                column: "OsiguranjeId");

            migrationBuilder.CreateIndex(
                name: "IX_PacijentOsiguranje_PacijentId",
                table: "PacijentOsiguranje",
                column: "PacijentId");

            migrationBuilder.CreateIndex(
                name: "IX_PacijentVakcinacija_PacijentId",
                table: "PacijentVakcinacija",
                column: "PacijentId");

            migrationBuilder.CreateIndex(
                name: "IX_PacijentVakcinacija_VakcinacijaId",
                table: "PacijentVakcinacija",
                column: "VakcinacijaId");

            migrationBuilder.CreateIndex(
                name: "IX_Pregled_DoktorId",
                table: "Pregled",
                column: "DoktorId");

            migrationBuilder.CreateIndex(
                name: "IX_Pregled_PacijentId",
                table: "Pregled",
                column: "PacijentId");

            migrationBuilder.CreateIndex(
                name: "IX_Pregled_TerapijaId",
                table: "Pregled",
                column: "TerapijaId");

            migrationBuilder.CreateIndex(
                name: "IX_Pregled_UputnicaId",
                table: "Pregled",
                column: "UputnicaId");

            migrationBuilder.CreateIndex(
                name: "IX_PreventivneMjere_PacijentId",
                table: "PreventivneMjere",
                column: "PacijentId");

            migrationBuilder.CreateIndex(
                name: "IX_SistematskiPregled_PacijentId",
                table: "SistematskiPregled",
                column: "PacijentId");

            migrationBuilder.CreateIndex(
                name: "IX_Termin_DoktorId",
                table: "Termin",
                column: "DoktorId");

            migrationBuilder.CreateIndex(
                name: "IX_Termin_PacijentId",
                table: "Termin",
                column: "PacijentId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Administrator");

            migrationBuilder.DropTable(
                name: "DodjeljeniDoktor");

            migrationBuilder.DropTable(
                name: "KorisnikUloga");

            migrationBuilder.DropTable(
                name: "Nalaz");

            migrationBuilder.DropTable(
                name: "OcjenaDoktor");

            migrationBuilder.DropTable(
                name: "PacijentOboljenja");

            migrationBuilder.DropTable(
                name: "PacijentOsiguranje");

            migrationBuilder.DropTable(
                name: "PacijentVakcinacija");

            migrationBuilder.DropTable(
                name: "Pregled");

            migrationBuilder.DropTable(
                name: "PreventivneMjere");

            migrationBuilder.DropTable(
                name: "SistematskiPregled");

            migrationBuilder.DropTable(
                name: "Termin");

            migrationBuilder.DropTable(
                name: "Uloga");

            migrationBuilder.DropTable(
                name: "Oboljenje");

            migrationBuilder.DropTable(
                name: "Osiguranje");

            migrationBuilder.DropTable(
                name: "Vakcinacija");

            migrationBuilder.DropTable(
                name: "Terapija");

            migrationBuilder.DropTable(
                name: "Uputnica");

            migrationBuilder.DropTable(
                name: "Doktor");

            migrationBuilder.DropTable(
                name: "Pacijent");

            migrationBuilder.DropTable(
                name: "Odjel");

            migrationBuilder.DropTable(
                name: "Korisnik");

            migrationBuilder.DropTable(
                name: "Bolnica");
        }
    }
}
