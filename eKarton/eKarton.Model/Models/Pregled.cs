using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Model.Models
{
    public class Pregled
    {
        public int PregledId { get; set; }
        public DateTime? Datum { get; set; } = null!;
        public string RazlogPosjete { get; set; } = null!;
        public string Dijagnoza { get; set; } = null!;
        public int TerapijaId { get; set; }
        public int UputnicaId { get; set; }
        public int DoktorId { get; set; }
        public int PacijentId { get; set; }

        //public virtual Doktor Doktor { get; set; } = null!;
        //public virtual Pacijent Pacijent { get; set; } = null!;
        //public virtual Terapija Terapija { get; set; } = null!;
        //public virtual Uputnica Uputnica { get; set; } = null!;
    }
}
