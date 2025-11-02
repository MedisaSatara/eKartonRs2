using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Service.Databases
{
    public class TransakcijaLog25062025
    {
        public int TransakcijaLogId {  get; set; }
        public int? KorisnikId { get; set; }
        public int? TransakcijeId { get; set; }
        public string? StariStatus { get; set; }
        public string? NoviStatus { get; set; }
        public DateTime? VrijemePromjene { get; set; }
        public virtual Korisnik Korisnik { get; set; }
        public virtual Transakcije25062025 Transakcije25062025 { get; set; }

    }
}
