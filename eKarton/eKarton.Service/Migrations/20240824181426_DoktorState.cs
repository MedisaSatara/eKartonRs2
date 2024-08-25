using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eKarton.Service.Migrations
{
    public partial class DoktorState : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<string>(
                name: "StateMachine",
                table: "Uputnica",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "nvarchar(max)",
                oldNullable: true);

            migrationBuilder.AddColumn<string>(
                name: "StateMachine",
                table: "Doktor",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "Doktor",
                keyColumn: "DoktorId",
                keyValue: 3001,
                column: "StateMachine",
                value: "active");

            migrationBuilder.UpdateData(
                table: "Doktor",
                keyColumn: "DoktorId",
                keyValue: 3002,
                column: "StateMachine",
                value: "active");

            migrationBuilder.UpdateData(
                table: "Doktor",
                keyColumn: "DoktorId",
                keyValue: 3003,
                column: "StateMachine",
                value: "active");

            migrationBuilder.UpdateData(
                table: "Doktor",
                keyColumn: "DoktorId",
                keyValue: 3004,
                column: "StateMachine",
                value: "active");

            migrationBuilder.UpdateData(
                table: "Doktor",
                keyColumn: "DoktorId",
                keyValue: 3005,
                column: "StateMachine",
                value: "archived");

            migrationBuilder.UpdateData(
                table: "Doktor",
                keyColumn: "DoktorId",
                keyValue: 3006,
                column: "StateMachine",
                value: "draft");

            migrationBuilder.UpdateData(
                table: "Doktor",
                keyColumn: "DoktorId",
                keyValue: 3007,
                column: "StateMachine",
                value: "draft");

            migrationBuilder.UpdateData(
                table: "Doktor",
                keyColumn: "DoktorId",
                keyValue: 3008,
                column: "StateMachine",
                value: "cancelled");

            migrationBuilder.UpdateData(
                table: "Doktor",
                keyColumn: "DoktorId",
                keyValue: 3009,
                column: "StateMachine",
                value: "active");

            migrationBuilder.UpdateData(
                table: "Doktor",
                keyColumn: "DoktorId",
                keyValue: 3010,
                column: "StateMachine",
                value: "active");

            migrationBuilder.UpdateData(
                table: "Doktor",
                keyColumn: "DoktorId",
                keyValue: 3011,
                column: "StateMachine",
                value: "archived");

            migrationBuilder.UpdateData(
                table: "Doktor",
                keyColumn: "DoktorId",
                keyValue: 3012,
                column: "StateMachine",
                value: "active");

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

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "StateMachine",
                table: "Doktor");

            migrationBuilder.AlterColumn<string>(
                name: "StateMachine",
                table: "Uputnica",
                type: "nvarchar(max)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)");

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "NaXIAjwCsvEPhRuLKk5a1hnAsig=", "Lps3cUwHS4ySTFdsIURW1w==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "U6Zkw1lsgj/enqhgIPNaOj6lWrQ=", "XqwGuaMNu0Nb7/uHAYi3JA==" });
        }
    }
}
