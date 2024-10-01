using eKarton.Model.Request.SearchObject;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Service.Services
{
    public interface IOcjenaDoktorService : ICRUDService<Model.Models.OcjenaDoktor, DoktorSearchObject, Model.Request.OcjenaDoktorInsertRequest, Model.Request.OcjenaDoktorUpdateRequest>
    {
    }
}
