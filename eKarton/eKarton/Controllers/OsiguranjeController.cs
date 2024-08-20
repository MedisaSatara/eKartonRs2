﻿using eKarton.Model.Request.SearchObject;
using eKarton.Model.Request;
using eKarton.Service.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eKarton.Controllers
{
    [Route("[controller]")]
    public class OsiguranjeController : BaseCRUDController<Model.Models.Osiguranje, PacijentSearchObject, PacijentInsertRequest, PacijentUpdateRequest>
    {
        public OsiguranjeController(ILogger<BaseController<Model.Models.Osiguranje, PacijentSearchObject>> logger, IOsiguranjeService service) : base(logger, service)
        {
        }

        public override Model.Models.Osiguranje Insert([FromBody] PacijentInsertRequest insert)
        {
            return base.Insert(insert);
        }

    }
}
