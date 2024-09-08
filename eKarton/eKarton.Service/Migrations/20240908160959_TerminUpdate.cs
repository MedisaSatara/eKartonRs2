using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eKarton.Service.Migrations
{
    public partial class TerminUpdate : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "7YaEJif3pBtDmN/T7A2OJyRZkrA=", "dDC201MWwZRS+iVQjvIVww==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "VrCaoA+2bgamoC0rnpTlvAPrHkk=", "BWDv46P0YRWxNEm1bCy9Tg==" });

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2024, 9, 8, 18, 9, 56, 190, DateTimeKind.Local).AddTicks(5014));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2024, 9, 8, 18, 9, 56, 190, DateTimeKind.Local).AddTicks(5075));

            migrationBuilder.InsertData(
                table: "Termin",
                columns: new[] { "TerminId", "Datum", "DoktorId", "PacijentId", "Razlog", "Vrijeme" },
                values: new object[,]
                {
                    { 7116, "22.05.2024", 3010, 5002, "rutinska kontrola", "09:15:00" },
                    { 7117, "15.07.2024", 3007, 5003, "rutinska kontrola", "09:15:00" },
                    { 7118, "12.12.2023", 3009, 5001, "rutinska kontrola", "09:15:00" },
                    { 7119, "11.02.2024", 3007, 5002, "rutinska kontrola", "09:15:00" }
                });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 7116);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 7117);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 7118);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 7119);

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
        }
    }
}
