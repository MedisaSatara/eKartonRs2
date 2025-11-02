using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Model.Request
{
    public class TransakcijaUpdateRequest
    {
     //   public int? TransakcijeId { get; set; }
     //   public int? KorisnikId { get; set; }
     //   public int? KategorijaTransakcijaId { get; set; }
        public int? Iznos { get; set; }
        public DateTime? DatumTransakcije { get; set; }
        public string? Opis { get; set; }
        public string? Status { get; set; }
        // public virtual Korisnik Korisnik { get; set; }
        // public virtual KategorijaTransakcija25062025 KategorijaTransakcija { get; set; }
    }
}
