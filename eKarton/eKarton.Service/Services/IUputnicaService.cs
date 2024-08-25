using eKarton.Model.Request;
using eKarton.Model.Request.SearchObject;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Service.Services
{
    public interface IUputnicaService : ICRUDService<Model.Models.Uputnica, BaseSearchObject, UputnicaInsertRequest, UputnicaUpdateRequest>
    {
       // Task<eKarton.Model.Models.Uputnica> Activate(int id);
    }
}
