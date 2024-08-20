using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Model
{
    public class ConflictException :Exception
    {
        public ConflictException(string message) : base(message)
        {
        }
    }
}
