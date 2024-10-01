using eKarton.Model.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Model.Request
{
    public class OcjenaDoktorUpdateRequest
    {
       // public int OcjenaId { get; set; }
        public int? Ocjena { get; set; }
        public string? Razlog { get; set; }
        public bool? Anonimno { get; set; }
        public int DoktorId { get; set; }
        public int? KorisnikId { get; set; }
        // public virtual Korisnik Korisnik { get; set; }

      //  public virtual Doktor Doktor { get; set; } = null!;
    }
}
