using eKarton.Model.Request.SearchObject;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Service.Services
{
    public interface IOsiguranjeService : ICRUDService<Model.Models.Osiguranje, PacijentSearchObject, Model.Request.PacijentInsertRequest, Model.Request.PacijentUpdateRequest>
    {
    }
}
