using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eKarton.Service.Migrations
{
    public partial class CijenaTermin : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<double>(
                name: "CijenaPregleda",
                table: "Termin",
                type: "float",
                nullable: true);

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

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "CijenaPregleda",
                table: "Termin");

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "X745lP3rC90XkN7ASyPqof1Wn4k=", "uVKLCLLVz6GWC+XY+0uu4w==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "69kuc6w3lHLbqzoTPl2XtW72KLU=", "ZdtETWrd1efbMZXQXJtR7Q==" });

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2024, 11, 12, 12, 40, 4, 806, DateTimeKind.Local).AddTicks(1791));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2024, 11, 12, 12, 40, 4, 806, DateTimeKind.Local).AddTicks(1851));
        }
    }
}
