using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eKarton.Service.Migrations
{
    public partial class pacijentUpdateKorisnikId : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "k507CnRQrQDpt7h3vP7CjpYG274=", "B1H4C7syRK1eyHCDXgcl4g==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "hgz4afcUsPgM1fnhQ12Abmpbihc=", "FZ0K5Wo9pgxaDpYzRfF8Kg==" });

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2024, 8, 21, 15, 11, 26, 363, DateTimeKind.Local).AddTicks(7366));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2024, 8, 21, 15, 11, 26, 363, DateTimeKind.Local).AddTicks(7422));
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "dgmZPga0TPofvNJK2WjjYRJEaWI=", "np+1VfZWYiPHoRHkVX3dNg==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "AxirRCuTrikLkM+8MoLz8zPqtB4=", "nfdZjq3uBdI6oszI4z4+aA==" });

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2024, 8, 21, 15, 1, 37, 40, DateTimeKind.Local).AddTicks(6266));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2024, 8, 21, 15, 1, 37, 40, DateTimeKind.Local).AddTicks(6317));
        }
    }
}
