using eKarton.Model.Request.SearchObject;
using eKarton.Service.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eKarton.Controllers
{
    [Route("[controller]")]
    public class UlogaController : BaseController<Model.Models.Uloga, BaseSearchObject>
    {
        public UlogaController(ILogger<BaseController<Model.Models.Uloga, BaseSearchObject>> logger, IUlogaService service) : base(logger, service)
        {
        }
    }
}
