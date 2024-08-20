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
    public class BolnicaService : BaseService<Model.Models.Bolnica, Databases.Bolnica, BaseSearchObject>, IBolnicaService
    {
        public BolnicaService(eKartonContext context, IMapper mapper)
            : base(context, mapper)
        {

        }
    }
}
