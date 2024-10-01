using eKarton.Model.Request.SearchObject;
using eKarton.Model.Request;
using eKarton.Service.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using eKarton.Model.Models;

namespace eKarton.Controllers
{
    [Route("[controller]")]
    public class OcjenaDoktorController : BaseCRUDController<OcjenaDoktor, DoktorSearchObject, OcjenaDoktorInsertRequest, OcjenaDoktorUpdateRequest>
    {
        public OcjenaDoktorController(ILogger<BaseController<Model.Models.OcjenaDoktor, DoktorSearchObject>> logger, IOcjenaDoktorService service) : base(logger, service)
        {
        }

        public override Model.Models.OcjenaDoktor Insert([FromBody] OcjenaDoktorInsertRequest insert)
        {
            return base.Insert(insert);
        }

    }
}
