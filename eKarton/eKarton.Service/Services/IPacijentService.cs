using eKarton.Model.Request.SearchObject;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Service.Services
{
    public interface IPacijentService : ICRUDService<Model.Models.Pacijent, PacijentSearchObject, Model.Request.PacijentInsertRequest, Model.Request.PacijentUpdateRequest>
    {
    }
}
