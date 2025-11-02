using eKarton.Model.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Model.Request
{
    public class RezervacijaProstoraUpdateRequest
    {
      //  public int RezervacijaProstoraId { get; set; }
      //  public int? KorisnikId { get; set; }
      //  public int? RadniProstorId { get; set; }
        public DateTime? DatumPocetka { get; set; }
        public int? TrajanjeRezervacije { get; set; }
        public string? StatusRezervacije { get; set; }
        public string? Napomena { get; set; }
      //  public virtual Korisnik Korisnik { get; set; }
      //  public virtual RadniProstor RadniProstor { get; set; }
    }
}
