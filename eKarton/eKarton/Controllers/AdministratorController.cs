using eKarton.Model.Request.SearchObject;
using eKarton.Service.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eKarton.Controllers
{
    [Route("[controller]")]
    public class AdministratorController : BaseController<Model.Models.Administrator, BaseSearchObject>
    {
        public AdministratorController(ILogger<BaseController<Model.Models.Administrator, BaseSearchObject>> logger, IAdministratorService service) : base(logger, service)
        {
        }
    }
}
