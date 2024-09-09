using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eKarton.Service.Migrations
{
    public partial class changedOcjena : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "mF+bqVUWsLhYwJ+SLDLS0gpjfzU=", "BnoF7fCJUOi+qlPzgIk+zg==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "GKmtbV4AfRl+P56M63Gv/L9/hy8=", "pQHU5sG9x+98+0VkWTYBng==" });

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2024, 9, 9, 16, 32, 18, 436, DateTimeKind.Local).AddTicks(6521));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2024, 9, 9, 16, 32, 18, 436, DateTimeKind.Local).AddTicks(6577));

            migrationBuilder.UpdateData(
                table: "OcjenaDoktor",
                keyColumn: "OcjenaId",
                keyValue: 3303,
                column: "Ocjena",
                value: 4);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
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

            migrationBuilder.UpdateData(
                table: "OcjenaDoktor",
                keyColumn: "OcjenaId",
                keyValue: 3303,
                column: "Ocjena",
                value: 8);
        }
    }
}
