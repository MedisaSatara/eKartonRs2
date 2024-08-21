using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eKarton.Service.Migrations
{
    public partial class pacijentUpdate : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Korisnik_Pacijent",
                table: "Pacijent");

            migrationBuilder.DropColumn(
                name: "KorisnickoIme",
                table: "Pacijent");

            migrationBuilder.DropColumn(
                name: "LozinkaHash",
                table: "Pacijent");

            migrationBuilder.DropColumn(
                name: "LozinkaSalt",
                table: "Pacijent");

            migrationBuilder.AlterColumn<int>(
                name: "KorisnikId",
                table: "Pacijent",
                type: "int",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "dgmZPga0TPofvNJK2WjjYRJEaWI=", "np+1VfZWYiPHoRHkVX3dNg==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "AxirRCuTrikLkM+8MoLz8zPqtB4=", "nfdZjq3uBdI6oszI4z4+aA==" });

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2024, 8, 21, 15, 1, 37, 40, DateTimeKind.Local).AddTicks(6266));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2024, 8, 21, 15, 1, 37, 40, DateTimeKind.Local).AddTicks(6317));

            migrationBuilder.UpdateData(
                table: "Pacijent",
                keyColumn: "PacijentId",
                keyValue: 5001,
                column: "KorisnikId",
                value: null);

            migrationBuilder.UpdateData(
                table: "Pacijent",
                keyColumn: "PacijentId",
                keyValue: 5002,
                column: "KorisnikId",
                value: null);

            migrationBuilder.UpdateData(
                table: "Pacijent",
                keyColumn: "PacijentId",
                keyValue: 5003,
                column: "KorisnikId",
                value: null);

            migrationBuilder.AddForeignKey(
                name: "FK_Pacijent_Korisnik_KorisnikId",
                table: "Pacijent",
                column: "KorisnikId",
                principalTable: "Korisnik",
                principalColumn: "KorisnikId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Pacijent_Korisnik_KorisnikId",
                table: "Pacijent");

            migrationBuilder.AlterColumn<int>(
                name: "KorisnikId",
                table: "Pacijent",
                type: "int",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "int",
                oldNullable: true);

            migrationBuilder.AddColumn<string>(
                name: "KorisnickoIme",
                table: "Pacijent",
                type: "nvarchar(20)",
                maxLength: 20,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "LozinkaHash",
                table: "Pacijent",
                type: "nvarchar(50)",
                maxLength: 50,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "LozinkaSalt",
                table: "Pacijent",
                type: "nvarchar(50)",
                maxLength: 50,
                nullable: true);

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "T7EASKk+28QKkDvtIqvbJ5cdnqM=", "bkd151t0IwAXqJTEMvArOw==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "rJ/ML1Fsx5yRLiWSdKKDkAptjuo=", "EtXJ7lV6p6Ku3IHXSszasg==" });

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2024, 8, 18, 21, 6, 4, 316, DateTimeKind.Local).AddTicks(9213));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2024, 8, 18, 21, 6, 4, 316, DateTimeKind.Local).AddTicks(9318));

            migrationBuilder.UpdateData(
                table: "Pacijent",
                keyColumn: "PacijentId",
                keyValue: 5001,
                columns: new[] { "KorisnickoIme", "KorisnikId", "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "pacijent1", 1002, "mwDa5Wdz2U+bTWEalAISh8aZhb8=", "Cf4+pxGPEziGdsuI7+bO4w==" });

            migrationBuilder.UpdateData(
                table: "Pacijent",
                keyColumn: "PacijentId",
                keyValue: 5002,
                columns: new[] { "KorisnickoIme", "KorisnikId", "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "Pacijent2", 1002, "OAEErK375loaBm3yY3RsoX68rqM=", "Cf4+pxGPEziGdsuI7+bO4w==" });

            migrationBuilder.UpdateData(
                table: "Pacijent",
                keyColumn: "PacijentId",
                keyValue: 5003,
                columns: new[] { "KorisnickoIme", "KorisnikId", "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "pacijent3", 1002, "hPXetNrw+UshgufuekRrxRgFflc=", "Cf4+pxGPEziGdsuI7+bO4w==" });

            migrationBuilder.AddForeignKey(
                name: "FK_Korisnik_Pacijent",
                table: "Pacijent",
                column: "KorisnikId",
                principalTable: "Korisnik",
                principalColumn: "KorisnikId");
        }
    }
}
