using eKarton.Model.Request.SearchObject;
using eKarton.Service.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eKarton.Controllers
{
    [Route("[controller]")]
    public class OdjelController : BaseController<Model.Models.Odjel, BaseSearchObject>
    {
        public OdjelController(ILogger<BaseController<Model.Models.Odjel, BaseSearchObject>> logger, IOdjelService service) : base(logger, service)
        {
        }
    }
}
