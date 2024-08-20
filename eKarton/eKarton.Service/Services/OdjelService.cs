using AutoMapper;
using eKarton.Model.Request.SearchObject;
using eKarton.Service.Databases;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Service.Services
{
    public class OdjelService : BaseService<Model.Models.Odjel, Databases.Odjel, BaseSearchObject>, IOdjelService
    {
        public OdjelService(eKartonContext context, IMapper mapper)
            : base(context, mapper)
        {

        }
    }
}
