using eKarton.Model.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Model.Request
{
    public class KorisnikZAdatakInserRequest03042025
    {
       // public int KorisnikZadaciId { get; set; }
        public DateTime? DatumPocetkaZadatka { get; set; }
        public DateTime? DatumZavrsetkaZadatka { get; set; }
        public string? Status { get; set; }
        public string? Napomena { get; set; }
        public string? Prioritet { get; set; }
        public int? KorisnikId { get; set; }
        public int? ZadatakId { get; set; }
       // public virtual Korisnik Korisnik { get; set; }
        //public virtual Zadaci03042025 Zadaci03042025 { get; set; }
    }
}
