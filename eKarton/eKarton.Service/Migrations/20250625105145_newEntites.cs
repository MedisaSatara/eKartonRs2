using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eKarton.Service.Migrations
{
    public partial class newEntites : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "KategorijaTransakcija25062025",
                columns: table => new
                {
                    KategorijaTransakcijaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    NazivKategorije = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    TipKategorije = table.Column<string>(type: "nvarchar(250)", maxLength: 250, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_KategorijaTransakcija25062025", x => x.KategorijaTransakcijaId);
                });

            migrationBuilder.CreateTable(
                name: "FinansijskiLimit250262025",
                columns: table => new
                {
                    FinansijskiLimitId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KategorijaTransakcijaId = table.Column<int>(type: "int", nullable: true),
                    IznosLimita = table.Column<int>(type: "int", maxLength: 20, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_FinansijskiLimit250262025", x => x.FinansijskiLimitId);
                    table.ForeignKey(
                        name: "FK_FinansijskiLimit250262025_KategorijaTransakcija25062025_KategorijaTransakcijaId",
                        column: x => x.KategorijaTransakcijaId,
                        principalTable: "KategorijaTransakcija25062025",
                        principalColumn: "KategorijaTransakcijaId");
                });

            migrationBuilder.CreateTable(
                name: "Transakcije25062025",
                columns: table => new
                {
                    TransakcijeId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KorisnikId = table.Column<int>(type: "int", nullable: false),
                    KategorijaTransakcijaId = table.Column<int>(type: "int", nullable: false),
                    Iznos = table.Column<int>(type: "int", maxLength: 20, nullable: true),
                    DatumTransakcije = table.Column<DateTime>(type: "datetime2", maxLength: 20, nullable: true),
                    Opis = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    Status = table.Column<string>(type: "nvarchar(250)", maxLength: 250, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Transakcije25062025", x => x.TransakcijeId);
                    table.ForeignKey(
                        name: "FK_Transakcije25062025_KategorijaTransakcija25062025_KategorijaTransakcijaId",
                        column: x => x.KategorijaTransakcijaId,
                        principalTable: "KategorijaTransakcija25062025",
                        principalColumn: "KategorijaTransakcijaId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Transakcije25062025_Korisnik_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnik",
                        principalColumn: "KorisnikId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "TransakcijaLog25062025",
                columns: table => new
                {
                    TransakcijaLogId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KorisnikId = table.Column<int>(type: "int", nullable: false),
                    TransakcijeId = table.Column<int>(type: "int", nullable: true),
                    StariStatus = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: true),
                    NoviStatus = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: true),
                    VrijemePromjene = table.Column<DateTime>(type: "datetime2", maxLength: 250, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TransakcijaLog25062025", x => x.TransakcijaLogId);
                    table.ForeignKey(
                        name: "FK_TransakcijaLog25062025_Korisnik_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnik",
                        principalColumn: "KorisnikId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_TransakcijaLog25062025_Transakcije25062025_TransakcijeId",
                        column: x => x.TransakcijeId,
                        principalTable: "Transakcije25062025",
                        principalColumn: "TransakcijeId");
                });

            migrationBuilder.InsertData(
                table: "KategorijaTransakcija25062025",
                columns: new[] { "KategorijaTransakcijaId", "NazivKategorije", "TipKategorije" },
                values: new object[,]
                {
                    { 5678, "Hrana", "Prihod" },
                    { 5679, "Prevoz", "Prihod" }
                });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "CtovOroD50AjuMZXYgU3JFlOx7Q=", "G6fiHGnd6/7hc1Pb3+V+2Q==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "5rYfMuborKHE7IMCujSpE7B8f10=", "MFpgauhf8L+27zRe+dzKaQ==" });

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 6, 25, 12, 51, 42, 814, DateTimeKind.Local).AddTicks(5557));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 6, 25, 12, 51, 42, 814, DateTimeKind.Local).AddTicks(5617));

            migrationBuilder.InsertData(
                table: "FinansijskiLimit250262025",
                columns: new[] { "FinansijskiLimitId", "IznosLimita", "KategorijaTransakcijaId" },
                values: new object[] { 8138, 300, 5678 });

            migrationBuilder.InsertData(
                table: "Transakcije25062025",
                columns: new[] { "TransakcijeId", "DatumTransakcije", "Iznos", "KategorijaTransakcijaId", "KorisnikId", "Opis", "Status" },
                values: new object[] { 8988, new DateTime(2025, 6, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), 200, 5678, 1002, "Transkacije racunom", "Planirano" });

            migrationBuilder.InsertData(
                table: "Transakcije25062025",
                columns: new[] { "TransakcijeId", "DatumTransakcije", "Iznos", "KategorijaTransakcijaId", "KorisnikId", "Opis", "Status" },
                values: new object[] { 8989, new DateTime(2025, 6, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), 500, 5679, 1002, "Transkacije racunom", "Planirano" });

            migrationBuilder.InsertData(
                table: "TransakcijaLog25062025",
                columns: new[] { "TransakcijaLogId", "KorisnikId", "NoviStatus", "StariStatus", "TransakcijeId", "VrijemePromjene" },
                values: new object[] { 8938, 1002, "Realizovano", "Planirano", 8988, new DateTime(2025, 6, 25, 12, 51, 42, 814, DateTimeKind.Local).AddTicks(5751) });

            migrationBuilder.InsertData(
                table: "TransakcijaLog25062025",
                columns: new[] { "TransakcijaLogId", "KorisnikId", "NoviStatus", "StariStatus", "TransakcijeId", "VrijemePromjene" },
                values: new object[] { 8939, 1002, "Otkazano", "Planirano", 8989, new DateTime(2025, 6, 25, 12, 51, 42, 814, DateTimeKind.Local).AddTicks(5762) });

            migrationBuilder.CreateIndex(
                name: "IX_FinansijskiLimit250262025_KategorijaTransakcijaId",
                table: "FinansijskiLimit250262025",
                column: "KategorijaTransakcijaId");

            migrationBuilder.CreateIndex(
                name: "IX_TransakcijaLog25062025_KorisnikId",
                table: "TransakcijaLog25062025",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_TransakcijaLog25062025_TransakcijeId",
                table: "TransakcijaLog25062025",
                column: "TransakcijeId");

            migrationBuilder.CreateIndex(
                name: "IX_Transakcije25062025_KategorijaTransakcijaId",
                table: "Transakcije25062025",
                column: "KategorijaTransakcijaId");

            migrationBuilder.CreateIndex(
                name: "IX_Transakcije25062025_KorisnikId",
                table: "Transakcije25062025",
                column: "KorisnikId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "FinansijskiLimit250262025");

            migrationBuilder.DropTable(
                name: "TransakcijaLog25062025");

            migrationBuilder.DropTable(
                name: "Transakcije25062025");

            migrationBuilder.DropTable(
                name: "KategorijaTransakcija25062025");

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "r1aXDZwuEWKqJBI6/7+gZUzQLq8=", "c6tNCuPeKobWRiJvf1U8XA==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "0F1XC4nRxUtu3JvIh6cOb2yfxio=", "ZBdCFni/Vjr18TN76vsyzQ==" });

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 6, 25, 5, 52, 24, 718, DateTimeKind.Local).AddTicks(1677));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 6, 25, 5, 52, 24, 718, DateTimeKind.Local).AddTicks(1726));
        }
    }
}
