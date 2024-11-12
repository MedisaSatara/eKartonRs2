using eKarton.Model.Request.SearchObject;
using eKarton.Model.Request;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using eKarton.Model.Models;

namespace eKarton.Service.Services
{
    public interface ITerminService : ICRUDService<Model.Models.Termin, TerminSearchObject, TerminInsertRequest, TerminUpdateRequest>
    {
        Task AcceptServiceRequest(int terminId);
        Task<Termin> Activate(int id);
        Task<List<string>> AllowedActions(int id);
    }
}
