using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eKarton.Service.Migrations
{
    public partial class UpdateDeleteBehaviorSetNull : Migration
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
                values: new object[] { "ds0geTy6Fnl3YQ95lLH/vTcbcBY=", "EtseoIMpzR3YcS/NKXzy+w==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "bNyLecaU7duqxYYc2YYABajadDk=", "8a9mOVtmrn3ZO1uxke0DhQ==" });

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 3, 3, 17, 45, 30, 155, DateTimeKind.Local).AddTicks(1090));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 3, 3, 17, 45, 30, 155, DateTimeKind.Local).AddTicks(1154));

            migrationBuilder.AddForeignKey(
                name: "FK_Odjel_Doktor",
                table: "Doktor",
                column: "OdjelId",
                principalTable: "Odjel",
                principalColumn: "OdjelId",
                onDelete: ReferentialAction.SetNull);
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
    }
}
