using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eKarton.Service.Migrations
{
    public partial class addedDataTehnickaPodrska : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "TehnickaPodrska",
                columns: table => new
                {
                    TehnickaPodrskaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    BrojPozivaDoSada = table.Column<int>(type: "int", nullable: true),
                    NajcesciProblemi = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    BolnicaId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TehnickaPodrska", x => x.TehnickaPodrskaId);
                    table.ForeignKey(
                        name: "FK_TehnickaPodrska_Bolnica_BolnicaId",
                        column: x => x.BolnicaId,
                        principalTable: "Bolnica",
                        principalColumn: "BolnicaId");
                });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "wWrUc1aQjjQpGb+PkdlzHPtIUqA=", "kk+er/CplJ1+Qui4M1nphw==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "LrSJOYlJnrBfku9KgmYVUcVst1o=", "2bzS7lxYe52HVDNpdYYtOw==" });

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2024, 11, 11, 22, 39, 55, 520, DateTimeKind.Local).AddTicks(3849));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2024, 11, 11, 22, 39, 55, 520, DateTimeKind.Local).AddTicks(3903));

            migrationBuilder.InsertData(
                table: "TehnickaPodrska",
                columns: new[] { "TehnickaPodrskaId", "BolnicaId", "BrojPozivaDoSada", "NajcesciProblemi" },
                values: new object[,]
                {
                    { 2201, 1000, 2, "problem pri logiranju" },
                    { 2202, 1000, 3, "problem pri zdravstevnom osiguranju" }
                });

            migrationBuilder.CreateIndex(
                name: "IX_TehnickaPodrska_BolnicaId",
                table: "TehnickaPodrska",
                column: "BolnicaId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "TehnickaPodrska");

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "rQ84HlQTDL2pBYQzA+hPH1MKJy4=", "EEUPz1N+HeL9w+MmdMlGDg==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "+WGTs3m/kwhusfg6elOvlo8kGnE=", "r0kP//0am4BcQ4Ks4DCb7g==" });

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2024, 11, 11, 22, 34, 53, 570, DateTimeKind.Local).AddTicks(2024));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2024, 11, 11, 22, 34, 53, 570, DateTimeKind.Local).AddTicks(2082));
        }
    }
}
