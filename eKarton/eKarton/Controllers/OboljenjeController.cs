using eKarton.Model.Request.SearchObject;
using eKarton.Service.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eKarton.Controllers
{
    [Route("[controller]")]
    public class OboljenjeController : BaseController<Model.Models.Oboljenje, PacijentClassesSearchObject>
    {
        public OboljenjeController(ILogger<BaseController<Model.Models.Oboljenje, PacijentClassesSearchObject>> logger, IOboljenjeService service) : base(logger, service)
        {
        }
    }
}
