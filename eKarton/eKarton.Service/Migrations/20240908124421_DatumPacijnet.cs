using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eKarton.Service.Migrations
{
    public partial class DatumPacijnet : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<DateTime>(
                name: "DatumRodjenja",
                table: "Pacijent",
                type: "datetime2",
                maxLength: 10,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(10)",
                oldMaxLength: 10,
                oldNullable: true);

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
                table: "Pacijent",
                keyColumn: "PacijentId",
                keyValue: 5001,
                column: "DatumRodjenja",
                value: new DateTime(1998, 12, 11, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.UpdateData(
                table: "Pacijent",
                keyColumn: "PacijentId",
                keyValue: 5002,
                column: "DatumRodjenja",
                value: new DateTime(1980, 5, 8, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.UpdateData(
                table: "Pacijent",
                keyColumn: "PacijentId",
                keyValue: 5003,
                column: "DatumRodjenja",
                value: new DateTime(1992, 11, 12, 0, 0, 0, 0, DateTimeKind.Unspecified));
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<string>(
                name: "DatumRodjenja",
                table: "Pacijent",
                type: "nvarchar(10)",
                maxLength: 10,
                nullable: true,
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldMaxLength: 10,
                oldNullable: true);

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "PphSEvdQAob4GrrdAM4ZjDh3Yjo=", "T4UBhg3EXqUtZhc3BGvZ9w==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "LhqPeLNejZ8Mrw071VEyxccRVcY=", "q4KiMmjg100qpMCb0n2S/w==" });

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2024, 9, 8, 12, 19, 33, 318, DateTimeKind.Local).AddTicks(9995));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2024, 9, 8, 12, 19, 33, 319, DateTimeKind.Local).AddTicks(57));

            migrationBuilder.UpdateData(
                table: "Pacijent",
                keyColumn: "PacijentId",
                keyValue: 5001,
                column: "DatumRodjenja",
                value: "1998-12-11");

            migrationBuilder.UpdateData(
                table: "Pacijent",
                keyColumn: "PacijentId",
                keyValue: 5002,
                column: "DatumRodjenja",
                value: "1980-05-08");

            migrationBuilder.UpdateData(
                table: "Pacijent",
                keyColumn: "PacijentId",
                keyValue: 5003,
                column: "DatumRodjenja",
                value: "1992-11-12");
        }
    }
}
