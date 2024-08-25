using eKarton.Model.Request.SearchObject;
using eKarton.Model.Request;
using eKarton.Service.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eKarton.Controllers
{
    [Route("[controller]")]
    public class PacijentOsiguranjeController : BaseCRUDController<Model.Models.PacijentOsiguranje, PacijentSearchObject, PacijentOsiguranjeInsertRequest, PacijentOsiguranjeUpdateRequest>
    {
        public PacijentOsiguranjeController(ILogger<BaseController<Model.Models.PacijentOsiguranje, PacijentSearchObject>> logger, IPacijentOsiguranjeService service) : base(logger, service)
        {
        }

        public override Model.Models.PacijentOsiguranje Insert([FromBody] PacijentOsiguranjeInsertRequest insert)
        {
            return base.Insert(insert);
        }

    }
}
