﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Model.Request
{
    public class KorisnikUlogaUpdateRequest
    {
        public int? KorisnikId { get; set; }
        public int? UlogaId { get; set; }
        public DateTime? DatumIzmjene { get; set; }
    }
}
