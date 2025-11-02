using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Model.Request.SearchObject
{
    public class KorisnikZadatakSearchRequest03042025:BaseSearchObject
    {
        public string? ImeKorisnika { get; set; }
        public string? NazivZadatka { get; set; }
        public string? Status { get; set; }

    }
}
