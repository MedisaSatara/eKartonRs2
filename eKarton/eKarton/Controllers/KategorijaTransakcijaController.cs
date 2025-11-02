using eKarton.Model.Request.SearchObject;
using eKarton.Model.Request;
using eKarton.Service.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eKarton.Controllers
{
    [Route("[controller]")]
    public class KategorijaTransakcijaController : BaseCRUDController<Model.Models.KategorijaTransakcija25062025, KategorijaTransakcijaSearchObject, KategorijaTransakcijaInsertRequest, KategorijaTransakcijaUpdateRequest>
    {
        public KategorijaTransakcijaController(ILogger<BaseController<Model.Models.KategorijaTransakcija25062025, KategorijaTransakcijaSearchObject>> logger, IKategorijaTranskacijaService service) : base(logger, service)
        {
        }
    }
}
