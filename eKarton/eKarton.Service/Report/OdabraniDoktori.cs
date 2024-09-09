using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Service.Report
{
    public class OdabraniDoktori
    {
        public string? ImeDoktora { get; set; }
        public string? PrezimeDoktora { get; set; }
        public string? DatumRodjenja { get; set; }
        public string? Telefon { get; set; }
        public string? Email { get; set; }

        public string? Specijalizacija { get; set; }
        public int? BrojZakazanihTermina { get; set; }
    }
}
