using eKarton.Model.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Model.Request
{
    public class DoktorInsertRequest
    {
       // public int DoktorId { get; set; }
        public string Ime { get; set; } = null!;
        public string Prezime { get; set; } = null!;
        public string? Spol { get; set; }
        public string? DatumRodjenja { get; set; }
        public string? Grad { get; set; }
        public string Jmbg { get; set; } = null!;
        public string? Telefon { get; set; }
        //public string? StateMachine { get; set; }

        public string? Email { get; set; }
        public int OdjelId { get; set; }

       // public virtual Odjel Odjel { get; set; } = null!;
    }
}
