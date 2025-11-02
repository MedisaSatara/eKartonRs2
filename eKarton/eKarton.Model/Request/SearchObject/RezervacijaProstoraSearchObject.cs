using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Model.Request.SearchObject
{
    public class RezervacijaProstoraSearchObject:BaseSearchObject
    {
        public string? KorisnikIme { get;set; }
        public string? Oznaka { get;set; }
        public string? StatusRezervacije { get;set; }
    }
}
