using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Model.Models
{
    public class Termin
    {
        public int TerminId { get; set; }
        public string Datum { get; set; } = null!;
        public string Vrijeme { get; set; } = null!;
        public string? Razlog { get; set; }
        public int PacijentId { get; set; }
        public int DoktorId { get; set; }

      //  public virtual Doktor Doktor { get; set; } = null!;
      //  public virtual Pacijent Pacijent { get; set; } = null!;
    }
}
