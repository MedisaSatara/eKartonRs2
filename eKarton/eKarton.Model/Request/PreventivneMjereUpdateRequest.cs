using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Model.Request
{
    public class PreventivneMjereUpdateRequest
    {
        public string Stanje { get; set; } = null!;
        public int PacijentId { get; set; }
    }
}
