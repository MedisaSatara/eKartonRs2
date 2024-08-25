using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eKarton.Service.Migrations
{
    public partial class ocjeneDoktor : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "Lw8k4IjB38dSyFIZPfFUFTGUfHY=", "S7qokNux0ew7ktZwUNPE8w==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "rLd5MI7yBg2sa/eWqwUmEJjYDas=", "7DTLOvOtTBg12FwK+dovoQ==" });

            migrationBuilder.InsertData(
                table: "OcjenaDoktor",
                columns: new[] { "OcjenaId", "Anonimno", "DoktorId", "KorisnikId", "Ocjena", "Razlog" },
                values: new object[,]
                {
                    { 3301, true, 3012, 1002, 3, "Vrlo dobar" },
                    { 3302, true, 3007, 1002, 2, "Vrlo dobar" },
                    { 3303, true, 3008, 1002, 8, "Vrlo dobar" },
                    { 3304, true, 3006, 1002, 4, "Vrlo dobar" },
                    { 3305, true, 3005, 1002, 4, "Vrlo dobar" },
                    { 3400, true, 3001, 1002, 4, "Vrlo dobar" },
                    { 3500, true, 3002, 1002, 4, "Vrlo dobar" },
                    { 3600, true, 3003, 1002, 4, "Vrlo dobar" },
                    { 3700, true, 3004, 1002, 4, "Vrlo dobar" },
                    { 3800, true, 3010, 1002, 5, "Vrlo dobar" },
                    { 3900, true, 3011, 1002, 4, "Vrlo dobar" }
                });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "OcjenaDoktor",
                keyColumn: "OcjenaId",
                keyValue: 3301);

            migrationBuilder.DeleteData(
                table: "OcjenaDoktor",
                keyColumn: "OcjenaId",
                keyValue: 3302);

            migrationBuilder.DeleteData(
                table: "OcjenaDoktor",
                keyColumn: "OcjenaId",
                keyValue: 3303);

            migrationBuilder.DeleteData(
                table: "OcjenaDoktor",
                keyColumn: "OcjenaId",
                keyValue: 3304);

            migrationBuilder.DeleteData(
                table: "OcjenaDoktor",
                keyColumn: "OcjenaId",
                keyValue: 3305);

            migrationBuilder.DeleteData(
                table: "OcjenaDoktor",
                keyColumn: "OcjenaId",
                keyValue: 3400);

            migrationBuilder.DeleteData(
                table: "OcjenaDoktor",
                keyColumn: "OcjenaId",
                keyValue: 3500);

            migrationBuilder.DeleteData(
                table: "OcjenaDoktor",
                keyColumn: "OcjenaId",
                keyValue: 3600);

            migrationBuilder.DeleteData(
                table: "OcjenaDoktor",
                keyColumn: "OcjenaId",
                keyValue: 3700);

            migrationBuilder.DeleteData(
                table: "OcjenaDoktor",
                keyColumn: "OcjenaId",
                keyValue: 3800);

            migrationBuilder.DeleteData(
                table: "OcjenaDoktor",
                keyColumn: "OcjenaId",
                keyValue: 3900);

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
        }
    }
}
