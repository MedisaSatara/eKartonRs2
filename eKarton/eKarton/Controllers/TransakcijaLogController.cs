using eKarton.Model.Request.SearchObject;
using eKarton.Model.Request;
using eKarton.Service.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eKarton.Controllers
{
    [Route("[controller]")]
    public class TransakcijaLogController : BaseCRUDController<Model.Models.TransakcijaLog25062025, TransakcijaLogSearchObject, TransakcijaLogInsertRequest, TranskacijaLogUpdateRequest>
    {
        public TransakcijaLogController(ILogger<BaseController<Model.Models.TransakcijaLog25062025, TransakcijaLogSearchObject>> logger, ITransakcijaLogService service) : base(logger, service)
        {
        }
    }
}
