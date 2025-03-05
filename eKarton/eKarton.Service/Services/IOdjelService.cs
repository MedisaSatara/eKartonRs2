using eKarton.Model.Request.SearchObject;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Service.Services
{
    public interface IOdjelService : ICRUDService<Model.Models.Odjel, BaseSearchObject, Model.Request.OdjelInsertRequest, Model.Request.OdjelUpdateRequest>
    {
    }

}
