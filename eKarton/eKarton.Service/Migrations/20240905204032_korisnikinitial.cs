using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eKarton.Service.Migrations
{
    public partial class korisnikinitial : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "BE4CyLHz1oXyZT2MO6x9vNGauzc=", "YkaZ6TRmma0m5gzKV7V7iA==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "1rg4dAwyHaHbbfZC3ezZBp2ibcI=", "zZ3YUkvwvsFuu6e0YxBelw==" });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "xO3LbnfPovZSkaHxlP1hn6+EUy8=", "2i6lVv86WQ2HFIv+EGmRhQ==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "fPhgfI9jZ/4lHd27peX+HnKKn+A=", "q04nsexJGCotHDVIlxSkgg==" });
        }
    }
}
