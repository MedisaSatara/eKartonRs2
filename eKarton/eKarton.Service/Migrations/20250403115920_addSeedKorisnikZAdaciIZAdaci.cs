using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eKarton.Service.Migrations
{
    public partial class addSeedKorisnikZAdaciIZAdaci : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_KorisnikZadaci03042025_Korisnik_KorisnikId",
                table: "KorisnikZadaci03042025");

            migrationBuilder.DropForeignKey(
                name: "FK_KorisnikZadaci03042025_Zadaci03042025_Zadaci03042025ZadatakId",
                table: "KorisnikZadaci03042025");

            migrationBuilder.DropIndex(
                name: "IX_KorisnikZadaci03042025_Zadaci03042025ZadatakId",
                table: "KorisnikZadaci03042025");

            migrationBuilder.DropColumn(
                name: "Zadaci03042025ZadatakId",
                table: "KorisnikZadaci03042025");

            migrationBuilder.AlterColumn<int>(
                name: "KorisnikId",
                table: "KorisnikZadaci03042025",
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
                values: new object[] { "2WIwXityYLMHZJVsKHGHbSlQwNg=", "WiuJv8R/waxNhUIswT9P0A==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "73aYrWci33BNGIgQVFEMqJIdu0c=", "UJqcVXUZnQxxd1YUfcKEaQ==" });

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 4, 3, 13, 59, 18, 717, DateTimeKind.Local).AddTicks(9527));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 4, 3, 13, 59, 18, 717, DateTimeKind.Local).AddTicks(9582));

            migrationBuilder.InsertData(
                table: "Zadaci03042025",
                columns: new[] { "ZadatakId", "NazivZadatka" },
                values: new object[,]
                {
                    { 7201, "Organizacija FitCC" },
                    { 7202, "Takmicenje u fudbalu" },
                    { 7203, "Organizacija tribina" }
                });

            migrationBuilder.InsertData(
                table: "KorisnikZadaci03042025",
                columns: new[] { "KorisnikZadaciId", "DatumPocetkaZadatka", "DatumZavrsetkaZadatka", "KorisnikId", "Napomena", "Prioritet", "Status", "ZadatakId" },
                values: new object[] { 9201, new DateTime(2025, 4, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 5, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 1002, "organizovana takmicenja", "Visok", "Realizovan", 7201 });

            migrationBuilder.InsertData(
                table: "KorisnikZadaci03042025",
                columns: new[] { "KorisnikZadaciId", "DatumPocetkaZadatka", "DatumZavrsetkaZadatka", "KorisnikId", "Napomena", "Prioritet", "Status", "ZadatakId" },
                values: new object[] { 9202, new DateTime(2025, 5, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 5, 28, 0, 0, 0, 0, DateTimeKind.Unspecified), 1003, "organizovana takmicenja", "Srednji", "Realizovan", 7202 });

            migrationBuilder.InsertData(
                table: "KorisnikZadaci03042025",
                columns: new[] { "KorisnikZadaciId", "DatumPocetkaZadatka", "DatumZavrsetkaZadatka", "KorisnikId", "Napomena", "Prioritet", "Status", "ZadatakId" },
                values: new object[] { 9203, new DateTime(2025, 5, 16, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 5, 16, 0, 0, 0, 0, DateTimeKind.Unspecified), 1001, "organizovana takmicenja", "Nizak", "Otkazan", 7203 });

            migrationBuilder.CreateIndex(
                name: "IX_KorisnikZadaci03042025_ZadatakId",
                table: "KorisnikZadaci03042025",
                column: "ZadatakId");

            migrationBuilder.AddForeignKey(
                name: "FK_KorisnikZadaci03042025_Korisnik_KorisnikId",
                table: "KorisnikZadaci03042025",
                column: "KorisnikId",
                principalTable: "Korisnik",
                principalColumn: "KorisnikId",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_KorisnikZadaci03042025_Zadaci03042025_ZadatakId",
                table: "KorisnikZadaci03042025",
                column: "ZadatakId",
                principalTable: "Zadaci03042025",
                principalColumn: "ZadatakId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_KorisnikZadaci03042025_Korisnik_KorisnikId",
                table: "KorisnikZadaci03042025");

            migrationBuilder.DropForeignKey(
                name: "FK_KorisnikZadaci03042025_Zadaci03042025_ZadatakId",
                table: "KorisnikZadaci03042025");

            migrationBuilder.DropIndex(
                name: "IX_KorisnikZadaci03042025_ZadatakId",
                table: "KorisnikZadaci03042025");

            migrationBuilder.DeleteData(
                table: "KorisnikZadaci03042025",
                keyColumn: "KorisnikZadaciId",
                keyValue: 9201);

            migrationBuilder.DeleteData(
                table: "KorisnikZadaci03042025",
                keyColumn: "KorisnikZadaciId",
                keyValue: 9202);

            migrationBuilder.DeleteData(
                table: "KorisnikZadaci03042025",
                keyColumn: "KorisnikZadaciId",
                keyValue: 9203);

            migrationBuilder.DeleteData(
                table: "Zadaci03042025",
                keyColumn: "ZadatakId",
                keyValue: 7201);

            migrationBuilder.DeleteData(
                table: "Zadaci03042025",
                keyColumn: "ZadatakId",
                keyValue: 7202);

            migrationBuilder.DeleteData(
                table: "Zadaci03042025",
                keyColumn: "ZadatakId",
                keyValue: 7203);

            migrationBuilder.AlterColumn<int>(
                name: "KorisnikId",
                table: "KorisnikZadaci03042025",
                type: "int",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AddColumn<int>(
                name: "Zadaci03042025ZadatakId",
                table: "KorisnikZadaci03042025",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "WEs3rZhH4LvZzTs+j8ibkrs/+Vs=", "bXz4NYQpXyG9fxqs7pfF0Q==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "RhIfl5aZywtfHJYvVbYsSGa/YZI=", "lsJyHYhSzwQL79z6M4rGUg==" });

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 4, 3, 13, 50, 46, 227, DateTimeKind.Local).AddTicks(5863));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 4, 3, 13, 50, 46, 227, DateTimeKind.Local).AddTicks(5917));

            migrationBuilder.CreateIndex(
                name: "IX_KorisnikZadaci03042025_Zadaci03042025ZadatakId",
                table: "KorisnikZadaci03042025",
                column: "Zadaci03042025ZadatakId");

            migrationBuilder.AddForeignKey(
                name: "FK_KorisnikZadaci03042025_Korisnik_KorisnikId",
                table: "KorisnikZadaci03042025",
                column: "KorisnikId",
                principalTable: "Korisnik",
                principalColumn: "KorisnikId");

            migrationBuilder.AddForeignKey(
                name: "FK_KorisnikZadaci03042025_Zadaci03042025_Zadaci03042025ZadatakId",
                table: "KorisnikZadaci03042025",
                column: "Zadaci03042025ZadatakId",
                principalTable: "Zadaci03042025",
                principalColumn: "ZadatakId",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
