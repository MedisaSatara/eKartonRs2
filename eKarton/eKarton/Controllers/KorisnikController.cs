using eKarton.Model.Models;
using eKarton.Model.Request;
using eKarton.Model.Request.SearchObject;
using eKarton.Service.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eKarton.Controllers
{
    [Route("[controller]")]
    public class KorisnikController : BaseCRUDController<Model.Models.Korisnik, KorisnikSearchObject,KorisnikInsertRequest, KorisnikUpdateRequest>
    {
        public KorisnikController(ILogger<BaseController<Model.Models.Korisnik, KorisnikSearchObject>> logger, IKorisnikService service) : base(logger, service)
        {

        }

        //[Authorize(Roles = "Admin")]
        public override Korisnik Insert([FromBody] KorisnikInsertRequest insert)
        {
            return base.Insert(insert);
        }

    }
}
