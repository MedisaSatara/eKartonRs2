using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eKarton.Service.Migrations
{
    public partial class updatedoktorodjel : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Odjel_Doktor",
                table: "Doktor");

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "IGhMQKnwoIZ4wnKTAhDZlENFk0U=", "5S01PyDoN/yyky56pVN1DA==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "YG8dySpFM44F2sAg0ZoZBz2yZsI=", "SuL7I7bFbAhN9AmDk3/fxA==" });

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 3, 3, 17, 36, 28, 39, DateTimeKind.Local).AddTicks(5204));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 3, 3, 17, 36, 28, 39, DateTimeKind.Local).AddTicks(5263));

            migrationBuilder.AddForeignKey(
                name: "FK_Odjel_Doktor",
                table: "Doktor",
                column: "OdjelId",
                principalTable: "Odjel",
                principalColumn: "OdjelId",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Odjel_Doktor",
                table: "Doktor");

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "iWrmSmQM4GKhNVsg7h7Fa2IsLEQ=", "jOAiDSviFQqGn1jCBQNBMg==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "02bXhT4+xlwKXSygzQ66CBQJKBI=", "LX2x8QBwQT8aaSMiVwFSnA==" });

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 3, 3, 16, 23, 12, 649, DateTimeKind.Local).AddTicks(1955));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 3, 3, 16, 23, 12, 649, DateTimeKind.Local).AddTicks(2023));

            migrationBuilder.AddForeignKey(
                name: "FK_Odjel_Doktor",
                table: "Doktor",
                column: "OdjelId",
                principalTable: "Odjel",
                principalColumn: "OdjelId");
        }
    }
}
