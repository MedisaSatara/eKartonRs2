using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Model.Request
{
    public class TranskacijaLogUpdateRequest
    {
     //   public int TransakcijaLogId { get; set; }
      //  public int? KorisnikId { get; set; }
        public string? StariStatus { get; set; }
        public string? NoviStatus { get; set; }
        public DateTime? VrijemePromjene { get; set; }
        //  public virtual Korisnik Korisnik { get; set; }
    }
}
