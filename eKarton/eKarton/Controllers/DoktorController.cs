using eKarton.Model.Request.SearchObject;
using eKarton.Service.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eKarton.Controllers
{
    [Route("[controller]")]
    public class DoktorController : BaseController<Model.Models.Doktor, DoktorSearchObject>
    {
        public DoktorController(ILogger<BaseController<Model.Models.Doktor, DoktorSearchObject>> logger, IDoktorService service) : base(logger, service)
        {
        }
    }
}
