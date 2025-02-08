using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eKarton.Service.Migrations
{
    public partial class Transakcijskibroj : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "brojTransakcije",
                table: "Termin",
                type: "nvarchar(max)",
                nullable: true);

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
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "brojTransakcije",
                table: "Termin");

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "HFl3ynHkNImuFrmVPpUc2tzL5IM=", "s8kkRfcZKzaGt3STRuxhvQ==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "2x/TSG3LjO9iiYV7/gXkfpXJhVU=", "lSNlT4GsadVOsImBNmE9qA==" });

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 4, 23, 12, 6, 809, DateTimeKind.Local).AddTicks(8635));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 4, 23, 12, 6, 809, DateTimeKind.Local).AddTicks(8687));
        }
    }
}
