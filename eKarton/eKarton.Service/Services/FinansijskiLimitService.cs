using AutoMapper;
using eKarton.Model.Request;
using eKarton.Model.Request.SearchObject;
using eKarton.Service.Databases;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Service.Services
{
    public class FinansijskiLimit25062025 : BaseCRUDService<Model.Models.FinansijskiLimit25062025, Databases.FinansijskiLimit250262025, BaseSearchObject, FinansijskiLimitInsertRequest, FinansijskiLimitUpdateRequest>, IFinansijskiLimitService
    {
        public FinansijskiLimit25062025(eKartonContext context, IMapper mapper)
            : base(context, mapper)
        {
        }
    }
    }
