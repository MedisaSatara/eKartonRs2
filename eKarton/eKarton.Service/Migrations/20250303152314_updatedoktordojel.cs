using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eKarton.Service.Migrations
{
    public partial class updatedoktordojel : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Odjel_Doktor",
                table: "Doktor");

            migrationBuilder.AlterColumn<int>(
                name: "OdjelId",
                table: "Doktor",
                type: "int",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "int");

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

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Odjel_Doktor",
                table: "Doktor");

            migrationBuilder.AlterColumn<int>(
                name: "OdjelId",
                table: "Doktor",
                type: "int",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "int",
                oldNullable: true);

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "KWpRE+6Ad+w0IUm8Lz/IiE7oIRw=", "GB0mYunzBifZZaEwn0sl5Q==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "qIfRVb47M4KoVLbI59tKOQMKr6g=", "G2tdBDxcez4Bh7Mkiv8uLQ==" });

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 3, 3, 16, 20, 38, 118, DateTimeKind.Local).AddTicks(9422));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 3, 3, 16, 20, 38, 118, DateTimeKind.Local).AddTicks(9475));

            migrationBuilder.AddForeignKey(
                name: "FK_Odjel_Doktor",
                table: "Doktor",
                column: "OdjelId",
                principalTable: "Odjel",
                principalColumn: "OdjelId",
                onDelete: ReferentialAction.SetNull);
        }
    }
}
