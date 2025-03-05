using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Model.Request.SearchObject
{
    public class KorisnikUlogaSearchObject:BaseSearchObject
    {
        public string? ImeKorisnik { get; set; }
        public string? PrezimeKorisnika { get; set; }
        public string? NazivUloge {  get; set; }
        public bool? IsUlogaIncluded { get; set; }

    }
}
