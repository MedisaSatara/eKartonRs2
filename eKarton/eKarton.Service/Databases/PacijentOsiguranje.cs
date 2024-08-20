using System;
using System.Collections.Generic;

namespace eKarton.Service.Databases
{
    public partial class PacijentOsiguranje
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
