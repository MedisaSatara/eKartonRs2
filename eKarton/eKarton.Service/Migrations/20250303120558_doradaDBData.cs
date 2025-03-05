using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eKarton.Service.Migrations
{
    public partial class doradaDBData : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "/8v05bcwFnF15j7xYzzQNdTS/PA=", "GNpO3mvasp6NuxuSooYltA==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "yoMND6sjCyJpctjNKUIixYgEMZg=", "I6enPy7w/50VVv9uuO4kHA==" });

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 3, 3, 13, 5, 56, 317, DateTimeKind.Local).AddTicks(6793));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 3, 3, 13, 5, 56, 317, DateTimeKind.Local).AddTicks(6851));

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 7110,
                column: "Razlog",
                value: "Rutinska kontrola");

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 7116,
                column: "Razlog",
                value: "Rutinska kontrola");

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 7117,
                column: "Razlog",
                value: "Rutinska kontrola");

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 7118,
                column: "Razlog",
                value: "Rutinska kontrola");

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 7119,
                column: "Razlog",
                value: "Rutinska kontrola");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "Q/fQMhdkfrJKxrtG65bJ0XT9Llg=", "0rOInKXm8lGA96fu+s8y+w==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "jEReaCAyOuUsj1ZF9687I5/3dCg=", "fltinFJdaq25QeT7peqOqA==" });

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 7, 0, 20, 18, 360, DateTimeKind.Local).AddTicks(4935));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 7, 0, 20, 18, 360, DateTimeKind.Local).AddTicks(4977));

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 7110,
                column: "Razlog",
                value: "rutinska kontrola");

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 7116,
                column: "Razlog",
                value: "rutinska kontrola");

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 7117,
                column: "Razlog",
                value: "rutinska kontrola");

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 7118,
                column: "Razlog",
                value: "rutinska kontrola");

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 7119,
                column: "Razlog",
                value: "rutinska kontrola");
        }
    }
}
