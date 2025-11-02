using eKarton.Model.Request.SearchObject;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Service.Services
{
    public interface ITransakcijaService : ICRUDService<Model.Models.Transakcije25062025, TransakcijaSearchObject, Model.Request.TransakcijaInsertRequest, Model.Request.TransakcijaUpdateRequest>
    {
    }

}
