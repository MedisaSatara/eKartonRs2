using eKarton.Model.Request.SearchObject;
using eKarton.Model.Request;
using eKarton.Service.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eKarton.Controllers
{
    [Route("[controller]")]
    public class TransakcijaController : BaseCRUDController<Model.Models.Transakcije25062025, TransakcijaSearchObject, TransakcijaInsertRequest, TransakcijaUpdateRequest>
    {
        public TransakcijaController(ILogger<BaseController<Model.Models.Transakcije25062025, TransakcijaSearchObject>> logger, ITransakcijaService service) : base(logger, service)
        {
        }
    }
}
