using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eKarton.Service.Migrations
{
    public partial class datumType : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<DateTime>(
                name: "Datum",
                table: "Pregled",
                type: "datetime2",
                maxLength: 20,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(20)",
                oldMaxLength: 20);

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
                table: "Pregled",
                keyColumn: "PregledId",
                keyValue: 6110,
                column: "Datum",
                value: new DateTime(2022, 5, 5, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.UpdateData(
                table: "Pregled",
                keyColumn: "PregledId",
                keyValue: 6111,
                column: "Datum",
                value: new DateTime(2022, 5, 5, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.UpdateData(
                table: "Pregled",
                keyColumn: "PregledId",
                keyValue: 6112,
                column: "Datum",
                value: new DateTime(2022, 5, 5, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.UpdateData(
                table: "Pregled",
                keyColumn: "PregledId",
                keyValue: 6113,
                column: "Datum",
                value: new DateTime(2022, 5, 5, 0, 0, 0, 0, DateTimeKind.Unspecified));
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<string>(
                name: "Datum",
                table: "Pregled",
                type: "nvarchar(20)",
                maxLength: 20,
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldMaxLength: 20,
                oldNullable: true);

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "V8HYjW6R4eXd1YERVpYDxjGpIXQ=", "1OHtB2+h0331Qpoyujq+Jg==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "c0CHfrx40VPzDtq40L8awZnN+no=", "fRJjjjh8OSV2eZOhiCmbuQ==" });

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2024, 9, 6, 16, 26, 27, 952, DateTimeKind.Local).AddTicks(9798));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2024, 9, 6, 16, 26, 27, 952, DateTimeKind.Local).AddTicks(9870));

            migrationBuilder.UpdateData(
                table: "Pregled",
                keyColumn: "PregledId",
                keyValue: 6110,
                column: "Datum",
                value: "05.05.2022");

            migrationBuilder.UpdateData(
                table: "Pregled",
                keyColumn: "PregledId",
                keyValue: 6111,
                column: "Datum",
                value: "05.05.2022");

            migrationBuilder.UpdateData(
                table: "Pregled",
                keyColumn: "PregledId",
                keyValue: 6112,
                column: "Datum",
                value: "05.05.2022");

            migrationBuilder.UpdateData(
                table: "Pregled",
                keyColumn: "PregledId",
                keyValue: 6113,
                column: "Datum",
                value: "05.05.2022");
        }
    }
}
