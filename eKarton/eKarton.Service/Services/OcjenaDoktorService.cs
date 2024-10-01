using AutoMapper;
using eKarton.Model.Request.SearchObject;
using eKarton.Model.Request;
using eKarton.Service.Databases;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Service.Services
{
    public class OcjenaDoktorService : BaseCRUDService<Model.Models.OcjenaDoktor, Databases.OcjenaDoktor, DoktorSearchObject, OcjenaDoktorInsertRequest, OcjenaDoktorUpdateRequest>, IOcjenaDoktorService
    {
        public OcjenaDoktorService(eKartonContext context, IMapper mapper)
        : base(context, mapper)
        {
        }

    }
}
