using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Service.Databases
{
    public class FinansijskiLimit250262025
    {
        public int FinansijskiLimitId { get; set; }
        public int? KategorijaTransakcijaId { get; set; }
        public int? IznosLimita { get; set; }
        public virtual KategorijaTransakcija25062025 KategorijaTransakcija25062025 { get; set; }
    }
}
