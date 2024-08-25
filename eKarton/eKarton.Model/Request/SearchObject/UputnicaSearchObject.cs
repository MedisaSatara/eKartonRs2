using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Model.Request.SearchObject
{
    public class UputnicaSearchObject:BaseSearchObject
    {
        public string? ImePacijenta { get; set; }
        public string? PrezimePacijenta { get; set; }
        public string? BrojKartona { get; set; }
        public int? PacijentId { get; set; }
    }
}
