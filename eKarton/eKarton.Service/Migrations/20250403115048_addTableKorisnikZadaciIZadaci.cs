using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eKarton.Service.Migrations
{
    public partial class addTableKorisnikZadaciIZadaci : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Zadaci03042025",
                columns: table => new
                {
                    ZadatakId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    NazivZadatka = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Zadaci03042025", x => x.ZadatakId);
                });

            migrationBuilder.CreateTable(
                name: "KorisnikZadaci03042025",
                columns: table => new
                {
                    KorisnikZadaciId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    DatumPocetkaZadatka = table.Column<DateTime>(type: "datetime2", maxLength: 20, nullable: true),
                    DatumZavrsetkaZadatka = table.Column<DateTime>(type: "datetime2", maxLength: 20, nullable: true),
                    Status = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    Napomena = table.Column<string>(type: "nvarchar(250)", maxLength: 250, nullable: true),
                    Prioritet = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    KorisnikId = table.Column<int>(type: "int", nullable: true),
                    ZadatakId = table.Column<int>(type: "int", nullable: true),
                    Zadaci03042025ZadatakId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_KorisnikZadaci03042025", x => x.KorisnikZadaciId);
                    table.ForeignKey(
                        name: "FK_KorisnikZadaci03042025_Korisnik_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnik",
                        principalColumn: "KorisnikId");
                    table.ForeignKey(
                        name: "FK_KorisnikZadaci03042025_Zadaci03042025_Zadaci03042025ZadatakId",
                        column: x => x.Zadaci03042025ZadatakId,
                        principalTable: "Zadaci03042025",
                        principalColumn: "ZadatakId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "WEs3rZhH4LvZzTs+j8ibkrs/+Vs=", "bXz4NYQpXyG9fxqs7pfF0Q==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "RhIfl5aZywtfHJYvVbYsSGa/YZI=", "lsJyHYhSzwQL79z6M4rGUg==" });

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 4, 3, 13, 50, 46, 227, DateTimeKind.Local).AddTicks(5863));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 4, 3, 13, 50, 46, 227, DateTimeKind.Local).AddTicks(5917));

            migrationBuilder.CreateIndex(
                name: "IX_KorisnikZadaci03042025_KorisnikId",
                table: "KorisnikZadaci03042025",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_KorisnikZadaci03042025_Zadaci03042025ZadatakId",
                table: "KorisnikZadaci03042025",
                column: "Zadaci03042025ZadatakId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "KorisnikZadaci03042025");

            migrationBuilder.DropTable(
                name: "Zadaci03042025");

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "zNjjeX69b9H/Qu5SEo09HGEUGPw=", "mUK2AIG6FRG7urv9Ueg/pQ==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "ukwvZh3e/hjkqx67l6Lz6Z0bDFw=", "gIqTcZtZu+cygWcqSe1qLg==" });

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 4, 3, 13, 25, 33, 496, DateTimeKind.Local).AddTicks(8910));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 4, 3, 13, 25, 33, 496, DateTimeKind.Local).AddTicks(8983));
        }
    }
}
