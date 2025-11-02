using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Model.Request
{
    public class RadniProstorInsertRequest
    {
      //  public int RadniProstorId { get; set; }
        public string? Oznaka { get; set; }
        public string? Kapacitet { get; set; }
        public bool? Aktivna { get; set; }
    }
}
