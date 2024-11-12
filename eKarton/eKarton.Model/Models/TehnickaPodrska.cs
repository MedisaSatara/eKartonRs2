using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Model.Models
{
    public class TehnickaPodrska
    {
        public int? TehnickaPodrskaId { get; set; }
        public int? BrojPozivaDoSada { get; set; }
        public string? NajcesciProblemi { get; set; }
        public int? BolnicaId { get; set; }
       // public virtual Bolnica Bolnica { get; set; } = null!;
    }
}
