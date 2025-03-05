using eKarton.Model.Request;
using eKarton.Model.Request.SearchObject;
using eKarton.Service.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eKarton.Controllers
{
    [Route("[controller]")]
    public class OdjelController : BaseCRUDController<Model.Models.Odjel, BaseSearchObject, OdjelInsertRequest, OdjelUpdateRequest>
    {
        public OdjelController(ILogger<BaseController<Model.Models.Odjel, BaseSearchObject>> logger, IOdjelService service) : base(logger, service)
        {
        }
    }
}
