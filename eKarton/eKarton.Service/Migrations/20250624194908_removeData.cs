using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eKarton.Service.Migrations
{
    public partial class removeData : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "RezervacijaProstora20222025");

            migrationBuilder.DropTable(
                name: "RadniProstor20022025");

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "l7cMOcoxkoxjrpLK5DTLBYpGNko=", "p7Zf7OCicSzeJKdJneqbEg==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "6290cbB0XNLphKHuqjw3m8t7RSc=", "QE3oD/zq+rAqSTX9yyFDDQ==" });

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 6, 24, 21, 49, 6, 631, DateTimeKind.Local).AddTicks(198));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 6, 24, 21, 49, 6, 631, DateTimeKind.Local).AddTicks(251));
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "RadniProstor20022025",
                columns: table => new
                {
                    RadniProstor20022025Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Aktivna = table.Column<bool>(type: "bit", maxLength: 20, nullable: true),
                    Kapacitet = table.Column<string>(type: "nvarchar(250)", maxLength: 250, nullable: true),
                    Oznaka = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_RadniProstor20022025", x => x.RadniProstor20022025Id);
                });

            migrationBuilder.CreateTable(
                name: "RezervacijaProstora20222025",
                columns: table => new
                {
                    RezervacijaProstora20222025Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KorisnikId = table.Column<int>(type: "int", nullable: false),
                    RadniProstor20022025Id = table.Column<int>(type: "int", nullable: false),
                    DatumPocetka = table.Column<DateTime>(type: "datetime2", maxLength: 100, nullable: true),
                    Napomena = table.Column<string>(type: "nvarchar(250)", maxLength: 250, nullable: true),
                    StatusRezervacije = table.Column<string>(type: "nvarchar(250)", maxLength: 250, nullable: true),
                    TrajanjeRezervacije = table.Column<int>(type: "int", maxLength: 20, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_RezervacijaProstora20222025", x => x.RezervacijaProstora20222025Id);
                    table.ForeignKey(
                        name: "FK_RezervacijaProstora20222025_Korisnik_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnik",
                        principalColumn: "KorisnikId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_RezervacijaProstora20222025_RadniProstor20022025_RadniProstor20022025Id",
                        column: x => x.RadniProstor20022025Id,
                        principalTable: "RadniProstor20022025",
                        principalColumn: "RadniProstor20022025Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "iorghIHRABdGWIPpxtFmPNOFI68=", "OxPb8zayH/sGyd9xCxIhJA==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "E8ZxcP+WPSv10vVJS+L6gmzkxHg=", "5BfN6tPn9DkzYvxp4CjJkQ==" });

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 6, 24, 21, 45, 59, 780, DateTimeKind.Local).AddTicks(931));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 6, 24, 21, 45, 59, 780, DateTimeKind.Local).AddTicks(982));

            migrationBuilder.InsertData(
                table: "RadniProstor20022025",
                columns: new[] { "RadniProstor20022025Id", "Aktivna", "Kapacitet", "Oznaka" },
                values: new object[,]
                {
                    { 17201, true, "20 ljudi", "1234BH" },
                    { 17202, true, "20 ljudi", "1j34BH" },
                    { 17203, false, "20 ljudi", "194BH" }
                });

            migrationBuilder.InsertData(
                table: "RezervacijaProstora20222025",
                columns: new[] { "RezervacijaProstora20222025Id", "DatumPocetka", "KorisnikId", "Napomena", "RadniProstor20022025Id", "StatusRezervacije", "TrajanjeRezervacije" },
                values: new object[] { 19201, new DateTime(2025, 4, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 1002, "organizovana takmicenja", 17201, "Potvrđena", 10 });

            migrationBuilder.InsertData(
                table: "RezervacijaProstora20222025",
                columns: new[] { "RezervacijaProstora20222025Id", "DatumPocetka", "KorisnikId", "Napomena", "RadniProstor20022025Id", "StatusRezervacije", "TrajanjeRezervacije" },
                values: new object[] { 19202, new DateTime(2025, 5, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), 1003, "organizovana takmicenja", 17202, "Otkazana", 5 });

            migrationBuilder.InsertData(
                table: "RezervacijaProstora20222025",
                columns: new[] { "RezervacijaProstora20222025Id", "DatumPocetka", "KorisnikId", "Napomena", "RadniProstor20022025Id", "StatusRezervacije", "TrajanjeRezervacije" },
                values: new object[] { 19203, new DateTime(2025, 5, 16, 0, 0, 0, 0, DateTimeKind.Unspecified), 1001, "organizovana takmicenja", 17203, "Otkazana", 24 });

            migrationBuilder.CreateIndex(
                name: "IX_RezervacijaProstora20222025_KorisnikId",
                table: "RezervacijaProstora20222025",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_RezervacijaProstora20222025_RadniProstor20022025Id",
                table: "RezervacijaProstora20222025",
                column: "RadniProstor20022025Id");
        }
    }
}
