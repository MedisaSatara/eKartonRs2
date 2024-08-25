using eKarton.Model.Request.SearchObject;
using eKarton.Model.Request;
using eKarton.Service.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eKarton.Controllers
{
    [Route("[controller]")]
    public class PreventivneMjereController : BaseCRUDController<Model.Models.PreventivneMjere, PacijentSearchObject, PreventivneMjereInsertRequest, PreventivneMjereUpdateRequest>
    {
        public PreventivneMjereController(ILogger<BaseController<Model.Models.PreventivneMjere, PacijentSearchObject>> logger, IPreventivneMjere service) : base(logger, service)
        {
        }

        public override Model.Models.PreventivneMjere Insert([FromBody] PreventivneMjereInsertRequest insert)
        {
            return base.Insert(insert);
        }

    }
}
