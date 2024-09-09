using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Service.Report
{
    public class BolestiPoGodistuReport
    {
        public string Decade { get; set; } 
        public List<BolestStatistika> NajcesceBolesti { get; set; }
    }
}
