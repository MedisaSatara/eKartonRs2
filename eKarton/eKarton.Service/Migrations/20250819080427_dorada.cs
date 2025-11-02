using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eKarton.Service.Migrations
{
    public partial class dorada : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "kWfu94Cq1qFM/cloPMIfvJd7rEk=", "P1FxUsYNZEb7ybAD3YqFIg==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "+Jj23swxK6Xde91uMDe8wVCAnbk=", "ID1ZgZ8Cvan5ZsY6NtO4sQ==" });

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 8, 19, 10, 4, 25, 115, DateTimeKind.Local).AddTicks(1990));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 8, 19, 10, 4, 25, 115, DateTimeKind.Local).AddTicks(2043));

            migrationBuilder.UpdateData(
                table: "TransakcijaLog25062025",
                keyColumn: "TransakcijaLogId",
                keyValue: 8938,
                column: "VrijemePromjene",
                value: new DateTime(2025, 8, 19, 10, 4, 25, 115, DateTimeKind.Local).AddTicks(2123));

            migrationBuilder.UpdateData(
                table: "TransakcijaLog25062025",
                keyColumn: "TransakcijaLogId",
                keyValue: 8939,
                column: "VrijemePromjene",
                value: new DateTime(2025, 8, 19, 10, 4, 25, 115, DateTimeKind.Local).AddTicks(2130));
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
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

            migrationBuilder.UpdateData(
                table: "TransakcijaLog25062025",
                keyColumn: "TransakcijaLogId",
                keyValue: 8938,
                column: "VrijemePromjene",
                value: new DateTime(2025, 6, 25, 12, 51, 42, 814, DateTimeKind.Local).AddTicks(5751));

            migrationBuilder.UpdateData(
                table: "TransakcijaLog25062025",
                keyColumn: "TransakcijaLogId",
                keyValue: 8939,
                column: "VrijemePromjene",
                value: new DateTime(2025, 6, 25, 12, 51, 42, 814, DateTimeKind.Local).AddTicks(5762));
        }
    }
}
