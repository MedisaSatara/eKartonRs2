using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Model.Models
{
    public class PacijentOsiguranje
    {
        public int PacijentOsiguranjeId { get; set; }
        public int? PacijentId { get; set; }
        public int? OsiguranjeId { get; set; }
        public string? DatumOsiguranja { get; set; }
        public bool? Vazece { get; set; }

        public virtual Osiguranje? Osiguranje { get; set; }
        public virtual Pacijent? Pacijent { get; set; }
    }
}
