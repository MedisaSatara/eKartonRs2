using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eKarton.Service.Migrations
{
    public partial class korisnikupdate : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Korisnik_Uloga_UlogaId",
                table: "Korisnik");

            migrationBuilder.DropIndex(
                name: "IX_Korisnik_UlogaId",
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
                    DatumIzmjene = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_KorisnikUloga", x => x.KorisnikUlogaId);
                    table.ForeignKey(
                        name: "FK_KorisnikUloga_Korisnik_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnik",
                        principalColumn: "KorisnikId");
                    table.ForeignKey(
                        name: "FK_KorisnikUloga_Uloga_UlogaId",
                        column: x => x.UlogaId,
                        principalTable: "Uloga",
                        principalColumn: "UlogaId");
                });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "mRZshYbekLgB1WtWriGaN2emA2A=", "nxNV+vVbR8gSkbl5/29Qrg==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "qDczMaj3As3ZuTzDG9qoE+gEYIc=", "qvLpIKPSm8/rVxbqsM8DOg==" });

            migrationBuilder.InsertData(
                table: "KorisnikUloga",
                columns: new[] { "KorisnikUlogaId", "DatumIzmjene", "KorisnikId", "UlogaId" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 9, 6, 3, 2, 32, 963, DateTimeKind.Local).AddTicks(8475), 1001, 1 },
                    { 2, new DateTime(2024, 9, 6, 3, 2, 32, 963, DateTimeKind.Local).AddTicks(8544), 1002, 2 }
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

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "KorisnikUloga");

            migrationBuilder.AddColumn<int>(
                name: "UlogaId",
                table: "Korisnik",
                type: "int",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt", "UlogaId" },
                values: new object[] { "BE4CyLHz1oXyZT2MO6x9vNGauzc=", "YkaZ6TRmma0m5gzKV7V7iA==", 1 });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt", "UlogaId" },
                values: new object[] { "1rg4dAwyHaHbbfZC3ezZBp2ibcI=", "zZ3YUkvwvsFuu6e0YxBelw==", 2 });

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
    }
}
