using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Service.Report
{
    public class DoktorPreglediReport
    {
        public string? ImeDoktora { get; set; }
        public string? Specijalizacija { get; set; }
        public int? BrojPregleda { get; set; }
        public int? BrojPacijenata { get; set; }
    }
}
