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
    public class TehnickaPodrskaService : BaseService<Model.Models.TehnickaPodrska, Databases.TehnickaPodrska, BaseSearchObject>, ITehnickaPodrska
    {
        public TehnickaPodrskaService(eKartonContext context, IMapper mapper)
            : base(context, mapper)
        {

        }
    }
}
