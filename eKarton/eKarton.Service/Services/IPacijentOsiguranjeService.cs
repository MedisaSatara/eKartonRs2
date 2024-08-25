using eKarton.Model.Request.SearchObject;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Service.Services
{
    public interface IPacijentOsiguranjeService : ICRUDService<Model.Models.PacijentOsiguranje, PacijentSearchObject, Model.Request.PacijentOsiguranjeInsertRequest, Model.Request.PacijentOsiguranjeUpdateRequest>
    {
    }
}
