using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Model.Request
{
    public class PacijentOsiguranjeUpdateRequest
    {
        public int? PacijentId { get; set; }
        public int? OsiguranjeId { get; set; }
        public string? DatumOsiguranja { get; set; }
        public bool? Vazece { get; set; }
    }
}
