using eKarton.Model.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Model.Request
{
    public class OdjelInsertRequest
    {

      //  public int OdjelId { get; set; }
        public string Naziv { get; set; } = null!;
        public string? Telefon { get; set; }
        public int BolnicaId { get; set; }

    }
}
