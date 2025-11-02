using eKarton.Model.Request.SearchObject;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Service.Services
{
    public interface ITransakcijaLogService : ICRUDService<Model.Models.TransakcijaLog25062025, TransakcijaLogSearchObject, Model.Request.TransakcijaLogInsertRequest, Model.Request.TranskacijaLogUpdateRequest>
    {
    }
}
