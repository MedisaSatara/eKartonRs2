using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Model.Request
{
    public class TerminInsertRequest
    {
      //  public int TerminId { get; set; }
        public string Datum { get; set; } = null!;
        public string Vrijeme { get; set; } = null!;
        public string? Razlog { get; set; }
        public int PacijentId { get; set; }
        public int DoktorId { get; set; }

    }
}
