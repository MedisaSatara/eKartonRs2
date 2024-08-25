using eKarton.Model.Request.SearchObject;
using eKarton.Service.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eKarton.Controllers
{
    [Route("[controller]")]
    public class TerapijaController : BaseController<Model.Models.Terapija, BaseSearchObject>
    {
        public TerapijaController(ILogger<BaseController<Model.Models.Terapija, BaseSearchObject>> logger, ITerapijaService service) : base(logger, service)
        {
        }
    }
}
