using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Model.Request
{
    public class PromeniLozinkuRequest
    {
        public int KorisnikId { get; set; }
        public string StaraLozinka { get; set; }
        public string NovaLozinka { get; set; }
    }
}
