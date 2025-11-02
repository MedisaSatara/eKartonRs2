using eKarton.Model.Request.SearchObject;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Service.Services
{
    public interface IFinansijskiLimitService : ICRUDService<Model.Models.FinansijskiLimit25062025, BaseSearchObject, Model.Request.FinansijskiLimitInsertRequest, Model.Request.FinansijskiLimitUpdateRequest>
    {
    }
}
