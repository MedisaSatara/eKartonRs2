using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Model.Models
{
    public class Oboljenje
    {
        public int OboljenjeId { get; set; }
        public string? Dijagnoza { get; set; }
        public string? Terapija { get; set; }

       // public virtual ICollection<PacijentOboljenja> PacijentOboljenjas { get; set; }
    }
}
