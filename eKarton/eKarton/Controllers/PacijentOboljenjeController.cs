using eKarton.Model.Request.SearchObject;
using eKarton.Service.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eKarton.Controllers
{
    [Route("[controller]")]
    public class PacijentOboljenjeController : BaseController<Model.Models.PacijentOboljenja, PacijentSearchObject>
    {
        public PacijentOboljenjeController(ILogger<BaseController<Model.Models.PacijentOboljenja, PacijentSearchObject>> logger, IPacijentOboljenjeService service) : base(logger, service)
        {
        }
    }
}
