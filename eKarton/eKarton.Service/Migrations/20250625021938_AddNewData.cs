using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eKarton.Service.Migrations
{
    public partial class AddNewData : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "RadniProstor",
                columns: table => new
                {
                    RadniProstorId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Oznaka = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    Kapacitet = table.Column<string>(type: "nvarchar(250)", maxLength: 250, nullable: true),
                    Aktivna = table.Column<bool>(type: "bit", maxLength: 50, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_RadniProstor", x => x.RadniProstorId);
                });

            migrationBuilder.CreateTable(
                name: "RezervacijaProstora20022025",
                columns: table => new
                {
                    RezervacijaProstoraId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KorisnikId = table.Column<int>(type: "int", nullable: false),
                    RadniProstorId = table.Column<int>(type: "int", nullable: false),
                    DatumPocetka = table.Column<DateTime>(type: "datetime2", maxLength: 20, nullable: true),
                    TrajanjeRezervacije = table.Column<int>(type: "int", maxLength: 20, nullable: true),
                    StatusRezervacije = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    Napomena = table.Column<string>(type: "nvarchar(250)", maxLength: 250, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_RezervacijaProstora20022025", x => x.RezervacijaProstoraId);
                    table.ForeignKey(
                        name: "FK_RezervacijaProstora20022025_Korisnik_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnik",
                        principalColumn: "KorisnikId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_RezervacijaProstora20022025_RadniProstor_RadniProstorId",
                        column: x => x.RadniProstorId,
                        principalTable: "RadniProstor",
                        principalColumn: "RadniProstorId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "QA5lsQbO3fpw2VPiflqtHT3H9lE=", "1orxv1JV3Xuh9KHO6F0OfA==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "l51SE9OGp9f3EybvPkDCVdWRVhE=", "jhSGVv2CuLA2xyIuX1Hbqg==" });

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 6, 25, 4, 19, 36, 537, DateTimeKind.Local).AddTicks(707));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 6, 25, 4, 19, 36, 537, DateTimeKind.Local).AddTicks(758));

            migrationBuilder.InsertData(
                table: "RadniProstor",
                columns: new[] { "RadniProstorId", "Aktivna", "Kapacitet", "Oznaka" },
                values: new object[,]
                {
                    { 17201, true, "20 ljudi", "1234BH" },
                    { 17202, true, "20 ljudi", "1j34BH" },
                    { 17203, false, "20 ljudi", "194BH" }
                });

            migrationBuilder.InsertData(
                table: "RezervacijaProstora20022025",
                columns: new[] { "RezervacijaProstoraId", "DatumPocetka", "KorisnikId", "Napomena", "RadniProstorId", "StatusRezervacije", "TrajanjeRezervacije" },
                values: new object[] { 19201, new DateTime(2025, 4, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 1002, "organizovana takmicenja", 17201, "Potvrđena", 10 });

            migrationBuilder.InsertData(
                table: "RezervacijaProstora20022025",
                columns: new[] { "RezervacijaProstoraId", "DatumPocetka", "KorisnikId", "Napomena", "RadniProstorId", "StatusRezervacije", "TrajanjeRezervacije" },
                values: new object[] { 19202, new DateTime(2025, 5, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), 1003, "organizovana takmicenja", 17202, "Otkazana", 5 });

            migrationBuilder.InsertData(
                table: "RezervacijaProstora20022025",
                columns: new[] { "RezervacijaProstoraId", "DatumPocetka", "KorisnikId", "Napomena", "RadniProstorId", "StatusRezervacije", "TrajanjeRezervacije" },
                values: new object[] { 19203, new DateTime(2025, 5, 16, 0, 0, 0, 0, DateTimeKind.Unspecified), 1001, "organizovana takmicenja", 17203, "Otkazana", 24 });

            migrationBuilder.CreateIndex(
                name: "IX_RezervacijaProstora20022025_KorisnikId",
                table: "RezervacijaProstora20022025",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_RezervacijaProstora20022025_RadniProstorId",
                table: "RezervacijaProstora20022025",
                column: "RadniProstorId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "RezervacijaProstora20022025");

            migrationBuilder.DropTable(
                name: "RadniProstor");

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "irg0gFE51LUVj78opbFwEEesYX8=", "jFILqEOouD2HfWPV3CW/og==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "+NnOtDVkQ4grvL4aMk+hVZA5flM=", "03qmXZlWDCNYCigSW4X08A==" });

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 6, 24, 23, 56, 51, 50, DateTimeKind.Local).AddTicks(8893));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 6, 24, 23, 56, 51, 50, DateTimeKind.Local).AddTicks(8954));
        }
    }
}
