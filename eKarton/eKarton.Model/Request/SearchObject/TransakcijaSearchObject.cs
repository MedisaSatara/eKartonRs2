using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Model.Request.SearchObject
{
    public class TransakcijaSearchObject:BaseSearchObject
    {
        public string? Status { get; set; }
        public string? NazivKategorije { get; set; }
        public string? DatumTransakcije { get; set; }

    }
}
