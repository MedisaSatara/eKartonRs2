﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Model.Request.SearchObject
{
    public class TerminSearchObject:BaseSearchObject
    {
        public string? ImeDoktora { get; set; }
        public string? PrezimeDoktora { get; set; }


    }
}
