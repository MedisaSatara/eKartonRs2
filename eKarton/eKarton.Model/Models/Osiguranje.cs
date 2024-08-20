using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Model.Models
{
    public class Osiguranje
    {
        public int OsiguranjeId { get; set; }
        public string Osiguranik { get; set; } = null!;

        public virtual ICollection<PacijentOsiguranje> PacijentOsiguranjes { get; set; }
    }
}
