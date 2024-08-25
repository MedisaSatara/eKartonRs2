using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eKarton.Service.Migrations
{
    public partial class DoktorOcjenaDb : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "KorisnikId",
                table: "OcjenaDoktor",
                type: "int",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "cSr/8fXyC1PQmkpdvN5Oin1vqHY=", "hfdNQsoXeuFHIZN4Hf6bZA==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "EGerMHQpOVqUbbQPG/P+iQZooaQ=", "i7uHNedPpoYKtpKlvafIxA==" });

            migrationBuilder.UpdateData(
                table: "OcjenaDoktor",
                keyColumn: "OcjenaId",
                keyValue: 3100,
                column: "KorisnikId",
                value: 1002);

            migrationBuilder.UpdateData(
                table: "OcjenaDoktor",
                keyColumn: "OcjenaId",
                keyValue: 3200,
                column: "KorisnikId",
                value: 1002);

            migrationBuilder.UpdateData(
                table: "OcjenaDoktor",
                keyColumn: "OcjenaId",
                keyValue: 3300,
                column: "KorisnikId",
                value: 1002);

            migrationBuilder.CreateIndex(
                name: "IX_OcjenaDoktor_KorisnikId",
                table: "OcjenaDoktor",
                column: "KorisnikId");

            migrationBuilder.AddForeignKey(
                name: "FK_OcjenaDoktor_Korisnik_KorisnikId",
                table: "OcjenaDoktor",
                column: "KorisnikId",
                principalTable: "Korisnik",
                principalColumn: "KorisnikId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_OcjenaDoktor_Korisnik_KorisnikId",
                table: "OcjenaDoktor");

            migrationBuilder.DropIndex(
                name: "IX_OcjenaDoktor_KorisnikId",
                table: "OcjenaDoktor");

            migrationBuilder.DropColumn(
                name: "KorisnikId",
                table: "OcjenaDoktor");

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "0lskLMLPwy7QhH5q/Jzu0tCR+eY=", "mG+Iz/fPeL7QWDJGPSewZQ==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "8rk6QneFuhDuRmzrc+TcOY9qAj0=", "axUdIIIN2avWMV3PEXfZkQ==" });
        }
    }
}
