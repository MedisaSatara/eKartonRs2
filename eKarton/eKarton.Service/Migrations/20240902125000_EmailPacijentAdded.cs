using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eKarton.Service.Migrations
{
    public partial class EmailPacijentAdded : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "Email",
                table: "Pacijent",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "OCjs2I983SBQA49mSlCfguJGXFQ=", "KdX3AuqJEDD0rhuUVwyfUQ==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "k3hRWbVAGynxCb3svUswGKs2d1M=", "ZBRSS8MFbknEUNxIRfUfyA==" });

            migrationBuilder.UpdateData(
                table: "Pacijent",
                keyColumn: "PacijentId",
                keyValue: 5001,
                column: "Email",
                value: "josip@gmail.com");

            migrationBuilder.UpdateData(
                table: "Pacijent",
                keyColumn: "PacijentId",
                keyValue: 5002,
                column: "Email",
                value: "helena@gmail.com");

            migrationBuilder.UpdateData(
                table: "Pacijent",
                keyColumn: "PacijentId",
                keyValue: 5003,
                column: "Email",
                value: "melita@gmail.com");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Email",
                table: "Pacijent");

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
        }
    }
}
