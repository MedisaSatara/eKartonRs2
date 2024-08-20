using eKarton.Model.Request.SearchObject;
using eKarton.Model.Request;
using eKarton.Service.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using eKarton.Model.Models;

namespace eKarton.Controllers
{
    [Route("[controller]")]
    public class TerminController : BaseCRUDController<Model.Models.Termin, TerminSearchObject, TerminInsertRequest, TerminUpdateRequest>
    {
        public TerminController(ILogger<BaseController<Model.Models.Termin, TerminSearchObject>> logger, ITerminService service) : base(logger, service)
        {

        }

        public override Termin Insert([FromBody] TerminInsertRequest insert)
        {
            return base.Insert(insert);
        }

    }
}
