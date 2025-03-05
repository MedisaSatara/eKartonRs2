using eKarton.Model.Request.SearchObject;
using eKarton.Model.Request;
using eKarton.Service.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eKarton.Controllers
{
    [Route("[controller]")]
    public class KorisnikUlogaController : BaseCRUDController<Model.Models.KorisnikUloga, KorisnikUlogaSearchObject, KorisnikUlogaInsertRequest, KorisnikUlogaUpdateRequest>
    {
        public KorisnikUlogaController(ILogger<BaseController<Model.Models.KorisnikUloga, KorisnikUlogaSearchObject>> logger, IKorisnikUlogaService service) : base(logger, service)
        {

        }
    }
}
