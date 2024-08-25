using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Model.Models
{
    public class Nalaz
    {
        public int NalazId { get; set; }
        public string? Datum { get; set; }
        public string? LicnaAnamneza { get; set; }
        public string? RadnaAnamneza { get; set; }
        public int PacijentId { get; set; }

       // public virtual Pacijent Pacijent { get; set; } = null!;
    }
}
