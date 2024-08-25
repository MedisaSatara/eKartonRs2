using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Model.Models
{
    public class Uputnica
    {
        public int UputnicaId { get; set; }
        public string Naziv { get; set; } = null!;
        public string Datum { get; set; } = null!;
        public string Razlog { get; set; } = null!;
        public string StateMachine { get; set; } = null!;


        //public virtual ICollection<Pregled> Pregleds { get; set; }
    }
}
