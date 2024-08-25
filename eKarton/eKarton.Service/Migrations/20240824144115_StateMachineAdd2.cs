using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eKarton.Service.Migrations
{
    public partial class StateMachineAdd2 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "StateMachine",
                table: "Uputnica",
                type: "nvarchar(max)",
                nullable: true);

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

            migrationBuilder.UpdateData(
                table: "Uputnica",
                keyColumn: "UputnicaId",
                keyValue: 6100,
                column: "StateMachine",
                value: "arhived");

            migrationBuilder.InsertData(
                table: "Uputnica",
                columns: new[] { "UputnicaId", "Datum", "Naziv", "Razlog", "StateMachine" },
                values: new object[,]
                {
                    { 6101, "06.02.2022", "Alergo-test", "Moguca alergija na odredjene proizvode", "draft" },
                    { 6102, "06.02.2022", "CTG", "neki razlog", "cancelled" },
                    { 6103, "06.02.2022", "Endoskopija", "Bolovi u prsima", "active" }
                });

            migrationBuilder.InsertData(
                table: "Pregled",
                columns: new[] { "PregledId", "Datum", "Dijagnoza", "DoktorId", "PacijentId", "RazlogPosjete", "TerapijaId", "UputnicaId" },
                values: new object[] { 6111, "05.05.2022", "Moguca alergijska reakcija", 3001, 5001, "Moguca alergijska reakcija", 6001, 6101 });

            migrationBuilder.InsertData(
                table: "Pregled",
                columns: new[] { "PregledId", "Datum", "Dijagnoza", "DoktorId", "PacijentId", "RazlogPosjete", "TerapijaId", "UputnicaId" },
                values: new object[] { 6112, "05.05.2022", "Upala srednjeg uha", 3001, 5001, "Bol  uhu i glava", 6001, 6102 });

            migrationBuilder.InsertData(
                table: "Pregled",
                columns: new[] { "PregledId", "Datum", "Dijagnoza", "DoktorId", "PacijentId", "RazlogPosjete", "TerapijaId", "UputnicaId" },
                values: new object[] { 6113, "05.05.2022", "Sum na srcu", 3001, 5001, "Otezano kretanje", 6001, 6103 });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Pregled",
                keyColumn: "PregledId",
                keyValue: 6111);

            migrationBuilder.DeleteData(
                table: "Pregled",
                keyColumn: "PregledId",
                keyValue: 6112);

            migrationBuilder.DeleteData(
                table: "Pregled",
                keyColumn: "PregledId",
                keyValue: 6113);

            migrationBuilder.DeleteData(
                table: "Uputnica",
                keyColumn: "UputnicaId",
                keyValue: 6101);

            migrationBuilder.DeleteData(
                table: "Uputnica",
                keyColumn: "UputnicaId",
                keyValue: 6102);

            migrationBuilder.DeleteData(
                table: "Uputnica",
                keyColumn: "UputnicaId",
                keyValue: 6103);

            migrationBuilder.DropColumn(
                name: "StateMachine",
                table: "Uputnica");

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "EsChrkFR1E3rzKqhH8IAmxZvzis=", "DxgAL+mAI/uKaw+SEp1aOg==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "Lsx1IKARUTnYSLwOhaUOCqkJMQ8=", "KSHwruONaLACUywBGtoxpw==" });
        }
    }
}
