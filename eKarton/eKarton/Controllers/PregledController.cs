using eKarton.Model.Request.SearchObject;
using eKarton.Service.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eKarton.Controllers
{
    [Route("[controller]")]
    public class PregledController : BaseController<Model.Models.Pregled, PacijentClassesSearchObject>
    {
        public PregledController(ILogger<BaseController<Model.Models.Pregled, PacijentClassesSearchObject>> logger, IPregledService service) : base(logger, service)
        {
        }
    }
}
