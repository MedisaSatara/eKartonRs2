using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Model.Request
{
    public class KategorijaTransakcijaUpdateRequest
    {
       // public int KategorijaTransakcijaId { get; set; }
        public string? NazivKategorije { get; set; }
        public string? TipKategorije { get; set; }
    }
}
