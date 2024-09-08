using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eKarton.Service.Migrations
{
    public partial class updateOboljenjaPacijenta : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "aylDusYLgDUQAWFTL4YrF7UrbsY=", "ADERoiiF+tR4/vzwpoZGxg==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "1kVTJJgXoRN4wnR9jlpGdIbbrvI=", "oM0gdQiandRzK89XpteLeg==" });

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2024, 9, 8, 17, 30, 25, 207, DateTimeKind.Local).AddTicks(3478));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2024, 9, 8, 17, 30, 25, 207, DateTimeKind.Local).AddTicks(3529));

            migrationBuilder.InsertData(
                table: "Oboljenje",
                columns: new[] { "OboljenjeId", "Dijagnoza", "Terapija" },
                values: new object[] { 8021, "Upala pluca", "Tablete" });

            migrationBuilder.UpdateData(
                table: "PacijentOboljenja",
                keyColumn: "PacijentOboljenjaId",
                keyValue: 10,
                columns: new[] { "NesposobanZaRad", "NesposobanZaRadDo", "NesposobanZaRadOd" },
                values: new object[] { "Da", "12-05-2023", "12-05-2022" });

            migrationBuilder.InsertData(
                table: "PacijentOboljenja",
                columns: new[] { "PacijentOboljenjaId", "NesposobanZaRad", "NesposobanZaRadDo", "NesposobanZaRadOd", "OboljenjeId", "PacijentId" },
                values: new object[,]
                {
                    { 11, "Ne", " ", " ", 8010, 5001 },
                    { 12, "Da", "22-02-2024", "12-01-2024", 8020, 5001 }
                });

            migrationBuilder.InsertData(
                table: "PacijentOboljenja",
                columns: new[] { "PacijentOboljenjaId", "NesposobanZaRad", "NesposobanZaRadDo", "NesposobanZaRadOd", "OboljenjeId", "PacijentId" },
                values: new object[] { 13, "Ne", " ", " ", 8021, 5003 });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "PacijentOboljenja",
                keyColumn: "PacijentOboljenjaId",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "PacijentOboljenja",
                keyColumn: "PacijentOboljenjaId",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "PacijentOboljenja",
                keyColumn: "PacijentOboljenjaId",
                keyValue: 13);

            migrationBuilder.DeleteData(
                table: "Oboljenje",
                keyColumn: "OboljenjeId",
                keyValue: 8021);

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "08l1Be4Wgf5K0bq3hFk8YVQ1ZUs=", "LTnwY6cDbV3n1OhTNlw16Q==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "DDTnWRywXxcaGEBxKYBy9vNu8zg=", "xWaaexpNKEaCSizdCWICZA==" });

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2024, 9, 8, 14, 44, 19, 98, DateTimeKind.Local).AddTicks(8552));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2024, 9, 8, 14, 44, 19, 98, DateTimeKind.Local).AddTicks(8606));

            migrationBuilder.UpdateData(
                table: "PacijentOboljenja",
                keyColumn: "PacijentOboljenjaId",
                keyValue: 10,
                columns: new[] { "NesposobanZaRad", "NesposobanZaRadDo", "NesposobanZaRadOd" },
                values: new object[] { "Ne", " ", " " });
        }
    }
}
