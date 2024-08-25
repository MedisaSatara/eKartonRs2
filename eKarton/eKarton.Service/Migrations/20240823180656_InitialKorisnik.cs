using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eKarton.Service.Migrations
{
    public partial class InitialKorisnik : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "KorisnikUloga");

            migrationBuilder.AddColumn<string>(
                name: "DatumRodjenja",
                table: "Korisnik",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "Email",
                table: "Korisnik",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "Spol",
                table: "Korisnik",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "Telefon",
                table: "Korisnik",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<int>(
                name: "UlogaId",
                table: "Korisnik",
                type: "int",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "DatumRodjenja", "Email", "LozinkaHash", "LozinkaSalt", "Spol", "Telefon", "UlogaId" },
                values: new object[] { "1998/11/11", "administrator@gmail.com", "N9calK+y4zPCSPmZn9SAk0ZjsLs=", "C54yw6UgA89sLvQdktfwZw==", "Z", "063 222 333", 1 });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "DatumRodjenja", "Email", "LozinkaHash", "LozinkaSalt", "Spol", "Telefon", "UlogaId" },
                values: new object[] { "1998/05/07", "korisnik@gmail.com", "7fPhxgUW5GyBh5+Xt8LyW/AWsR4=", "doYEtLgTFupsyoQWuaVOXQ==", "Z", "063 111 333", 2 });

            migrationBuilder.CreateIndex(
                name: "IX_Korisnik_UlogaId",
                table: "Korisnik",
                column: "UlogaId");

            migrationBuilder.AddForeignKey(
                name: "FK_Korisnik_Uloga_UlogaId",
                table: "Korisnik",
                column: "UlogaId",
                principalTable: "Uloga",
                principalColumn: "UlogaId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Korisnik_Uloga_UlogaId",
                table: "Korisnik");

            migrationBuilder.DropIndex(
                name: "IX_Korisnik_UlogaId",
                table: "Korisnik");

            migrationBuilder.DropColumn(
                name: "DatumRodjenja",
                table: "Korisnik");

            migrationBuilder.DropColumn(
                name: "Email",
                table: "Korisnik");

            migrationBuilder.DropColumn(
                name: "Spol",
                table: "Korisnik");

            migrationBuilder.DropColumn(
                name: "Telefon",
                table: "Korisnik");

            migrationBuilder.DropColumn(
                name: "UlogaId",
                table: "Korisnik");

            migrationBuilder.CreateTable(
                name: "KorisnikUloga",
                columns: table => new
                {
                    KorisnikUlogaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KorisnikId = table.Column<int>(type: "int", nullable: true),
                    UlogaId = table.Column<int>(type: "int", nullable: true),
                    DatumIzmjene = table.Column<DateTime>(type: "date", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_KorisnikUloga", x => x.KorisnikUlogaId);
                    table.ForeignKey(
                        name: "FK_Korisnik_KorisnikUloga",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnik",
                        principalColumn: "KorisnikId");
                    table.ForeignKey(
                        name: "FK_Uloga_KorisnikUloga",
                        column: x => x.UlogaId,
                        principalTable: "Uloga",
                        principalColumn: "UlogaId");
                });

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

            migrationBuilder.InsertData(
                table: "KorisnikUloga",
                columns: new[] { "KorisnikUlogaId", "DatumIzmjene", "KorisnikId", "UlogaId" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 8, 21, 15, 11, 26, 363, DateTimeKind.Local).AddTicks(7366), 1001, 1 },
                    { 2, new DateTime(2024, 8, 21, 15, 11, 26, 363, DateTimeKind.Local).AddTicks(7422), 1002, 2 }
                });

            migrationBuilder.CreateIndex(
                name: "IX_KorisnikUloga_KorisnikId",
                table: "KorisnikUloga",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_KorisnikUloga_UlogaId",
                table: "KorisnikUloga",
                column: "UlogaId");
        }
    }
}
