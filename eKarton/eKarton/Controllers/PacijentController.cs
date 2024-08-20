using eKarton.Model.Request;
using eKarton.Model.Request.SearchObject;
using eKarton.Service.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eKarton.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class PacijentController : BaseCRUDController<Model.Models.Pacijent, PacijentSearchObject, PacijentInsertRequest, PacijentUpdateRequest>
    {
        public PacijentController(ILogger<BaseController<Model.Models.Pacijent, PacijentSearchObject>> logger, IPacijentService service) : base(logger, service)
        {
        }

        public override Model.Models.Pacijent Insert([FromBody] PacijentInsertRequest insert)
        {
            return base.Insert(insert);
        }

    }
}
