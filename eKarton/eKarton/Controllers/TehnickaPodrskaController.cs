using eKarton.Model.Request.SearchObject;
using eKarton.Service.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eKarton.Controllers
{
    [Route("[controller]")]
    public class TehnickaPodrskaController : BaseController<Model.Models.TehnickaPodrska, BaseSearchObject>
    {
        public TehnickaPodrskaController(ILogger<BaseController<Model.Models.TehnickaPodrska, BaseSearchObject>> logger, ITehnickaPodrska service) : base(logger, service)
        {
        }
    }
}
