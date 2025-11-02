using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eKarton.Service.Migrations
{
    public partial class doradadd : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "ModeTracker170012s");

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "KhrAfACp0MZ/y1Xwq2Q6QXJ8Uds=", "tL0I3yMKmROwjtdzhxJPtA==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "gkrIrbQS9xZPGr7nldwoWlJTcBY=", "T/oE1LADjyOd2wv1xdvjRQ==" });

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 4, 3, 1, 49, 45, 535, DateTimeKind.Local).AddTicks(972));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 4, 3, 1, 49, 45, 535, DateTimeKind.Local).AddTicks(1031));
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "ModeTracker170012s",
                columns: table => new
                {
                    ModeTrackerId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KorisnikId = table.Column<int>(type: "int", nullable: false),
                    DatumEvidencije = table.Column<DateTime>(type: "datetime2", nullable: true),
                    DodatniOpis = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Raspolozenje = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ModeTracker170012s", x => x.ModeTrackerId);
                    table.ForeignKey(
                        name: "FK_ModeTracker170012s_Korisnik_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnik",
                        principalColumn: "KorisnikId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "mQmzCe1ENQTHu3kA9YC7aXW/bXk=", "NFmx7NnvHeqzshutpTm7nA==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "T0wYfcEa+8gp97R2gDzltl36K88=", "HAI+ZmmEzWbYSrKQkwD3ZA==" });

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 4, 2, 22, 9, 33, 54, DateTimeKind.Local).AddTicks(7203));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 4, 2, 22, 9, 33, 54, DateTimeKind.Local).AddTicks(7257));

            migrationBuilder.InsertData(
                table: "ModeTracker170012s",
                columns: new[] { "ModeTrackerId", "DatumEvidencije", "DodatniOpis", "KorisnikId", "Raspolozenje" },
                values: new object[,]
                {
                    { 7201, new DateTime(2025, 2, 2, 0, 0, 0, 0, DateTimeKind.Unspecified), "Ispunjen u zivotu", 1002, "Sretan" },
                    { 7202, new DateTime(2025, 2, 22, 0, 0, 0, 0, DateTimeKind.Unspecified), "previse obaveza", 1002, "Umoran" }
                });

            migrationBuilder.CreateIndex(
                name: "IX_ModeTracker170012s_KorisnikId",
                table: "ModeTracker170012s",
                column: "KorisnikId");
        }
    }
}
