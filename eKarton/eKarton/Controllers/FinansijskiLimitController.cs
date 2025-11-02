using eKarton.Model.Request.SearchObject;
using eKarton.Model.Request;
using eKarton.Service.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eKarton.Controllers
{
    [Route("[controller]")]
    public class FinansijskiLimitController : BaseCRUDController<Model.Models.FinansijskiLimit25062025, BaseSearchObject, FinansijskiLimitInsertRequest, FinansijskiLimitUpdateRequest>
    {
        public FinansijskiLimitController(ILogger<BaseController<Model.Models.FinansijskiLimit25062025, BaseSearchObject>> logger, IFinansijskiLimitService service) : base(logger, service)
        {
        }
    }
}
