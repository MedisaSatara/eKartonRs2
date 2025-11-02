using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Model.Request
{
    public class FinansijskiLimitInsertRequest
    {
     //   public int FinansijskiLimitId { get; set; }
        public int? KategorijaTransakcijaId { get; set; }
        public int? IznosLimita { get; set; }
    }
}
