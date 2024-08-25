using eKarton.Model.Request;
using eKarton.Model.Request.SearchObject;
using eKarton.Service.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eKarton.Controllers
{
    [Route("[controller]")]
    public class UputnicaController : BaseCRUDController<Model.Models.Uputnica, BaseSearchObject, UputnicaInsertRequest, UputnicaUpdateRequest>
    {

        public UputnicaController(ILogger<BaseController<Model.Models.Uputnica, BaseSearchObject>> logger, IUputnicaService service) : base(logger, service)
        {

        }


       /* [HttpPut("{id}/activate")]
        public Model.Models.Uputnica Activate(int id)
        {
            return (_service as IUputnicaService).Activate(id);
        }*/
    }
}
