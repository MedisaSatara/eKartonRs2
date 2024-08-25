using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eKarton.Service.Migrations
{
    public partial class ocjeneDoktor2 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "NB6jdLG4bKbGj4CNNklSBZjaPTk=", "iD+4eruco/kDQHwztZt6KQ==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "Ufc1dELnNF15e8fGOQPgltP6N9o=", "7iiViZTTfiv3advvcAa92w==" });

            migrationBuilder.InsertData(
                table: "OcjenaDoktor",
                columns: new[] { "OcjenaId", "Anonimno", "DoktorId", "KorisnikId", "Ocjena", "Razlog" },
                values: new object[,]
                {
                    { 3306, true, 3005, 1002, 2, "Vrlo dobar" },
                    { 3307, true, 3005, 1002, 3, "Vrlo dobar" },
                    { 3308, true, 3005, 1002, 5, "Vrlo dobar" },
                    { 3309, true, 3005, 1002, 4, "Vrlo dobar" },
                    { 3405, true, 3007, 1002, 4, "Vrlo dobar" },
                    { 3505, true, 3007, 1002, 4, "Vrlo dobar" },
                    { 3605, true, 3008, 1002, 4, "Vrlo dobar" },
                    { 3705, true, 3008, 1002, 4, "Vrlo dobar" },
                    { 3709, true, 3009, 1002, 4, "Vrlo dobar" }
                });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "OcjenaDoktor",
                keyColumn: "OcjenaId",
                keyValue: 3306);

            migrationBuilder.DeleteData(
                table: "OcjenaDoktor",
                keyColumn: "OcjenaId",
                keyValue: 3307);

            migrationBuilder.DeleteData(
                table: "OcjenaDoktor",
                keyColumn: "OcjenaId",
                keyValue: 3308);

            migrationBuilder.DeleteData(
                table: "OcjenaDoktor",
                keyColumn: "OcjenaId",
                keyValue: 3309);

            migrationBuilder.DeleteData(
                table: "OcjenaDoktor",
                keyColumn: "OcjenaId",
                keyValue: 3405);

            migrationBuilder.DeleteData(
                table: "OcjenaDoktor",
                keyColumn: "OcjenaId",
                keyValue: 3505);

            migrationBuilder.DeleteData(
                table: "OcjenaDoktor",
                keyColumn: "OcjenaId",
                keyValue: 3605);

            migrationBuilder.DeleteData(
                table: "OcjenaDoktor",
                keyColumn: "OcjenaId",
                keyValue: 3705);

            migrationBuilder.DeleteData(
                table: "OcjenaDoktor",
                keyColumn: "OcjenaId",
                keyValue: 3709);

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
        }
    }
}
