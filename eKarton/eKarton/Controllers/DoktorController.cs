using eKarton.Model.Models;
using eKarton.Model.Request;
using eKarton.Model.Request.SearchObject;
using eKarton.Service.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eKarton.Controllers
{
    [Route("[controller]")]
    public class DoktorController : BaseCRUDDoktorController<Doktor, DoktorSearchObject, DoktorInsertRequest, DoktorUpdateRequest>
    {
        public DoktorController(ILogger<BaseDoktorController<Doktor, DoktorSearchObject>> logger, IDoktorService service) : base(logger, service)
        {

        }

        [HttpPut("{id}/activate")]
        public virtual async Task<Doktor> Activate(int id)
        {
            return await (_service as IDoktorService).Activate(id);
        }


        [HttpPut("{id}/hide")]
        public virtual async Task<Doktor> Hide(int id)
        {
            return await (_service as IDoktorService).Hide(id);
        }
       /* [HttpGet("{id}/allowedActions")]
        public virtual async Task<List<string>> AllowedActions(int id)
        {
            return await (_service as IDoktorService).AllowedActions(id);
        }*/
       [HttpGet("preporuceno/{id}")]
        public List<eKarton.Model.Models.Doktor> GetPreporuceniDoktor(int id)
        {
            return _service.GetPreporuceniDoktor(id);
        }
        [HttpGet("preporuceni")]
        public ActionResult<List<Model.Models.Doktor>> GetRecommendedDoctors()
        {
            var recommendedDoctors = _service.GetRecommendedDoctors();
            return Ok(recommendedDoctors);
        }
        /* [HttpGet("preporucenim/{id}")]
         public ActionResult<List<Model.Models.Doktor>> GetRecommendedDoctorsForUser(int userId)
         {
             var recommendedDoctors = _service.GetRecommendedDoctorsForUser(userId);
             return Ok(recommendedDoctors);
         }*/
       /* [HttpGet("preporuceno/{korisnikId}")]
        public IActionResult GetRecommendedDoctors(int korisnikId)
        {
            var recommendedDoctors = _service.RecommendDoctors(korisnikId);
            return Ok(recommendedDoctors);
        }*/


    }
}
