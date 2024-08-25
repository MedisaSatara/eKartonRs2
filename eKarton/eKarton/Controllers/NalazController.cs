using eKarton.Model.Request.SearchObject;
using eKarton.Service.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eKarton.Controllers
{
    [Route("[controller]")]
    public class NalazController : BaseController<Model.Models.Nalaz, PacijentClassesSearchObject>
    {
        public NalazController(ILogger<BaseController<Model.Models.Nalaz, PacijentClassesSearchObject>> logger, INalazService service) : base(logger, service)
        {
        }
    }
}
