using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Model.Models
{
    public class PacijentOboljenja
    {
        public int PacijentOboljenjaId { get; set; }
        public int? OboljenjeId { get; set; }
        public int? PacijentId { get; set; }
        public string? NesposobanZaRad { get; set; }
        public string? NesposobanZaRadOd { get; set; }
        public string? NesposobanZaRadDo { get; set; }

        //public virtual Oboljenje? Oboljenje { get; set; }
        //public virtual Pacijent? Pacijent { get; set; }
    }
}
