using AutoMapper;
using eKarton.Model.Request.SearchObject;
using eKarton.Model.Request;
using eKarton.Service.Databases;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace eKarton.Service.Services
{
    public class OsiguranjeService : BaseCRUDService<Model.Models.Osiguranje, Databases.Osiguranje, PacijentSearchObject, OsiguranjeInsertRequest, OsiguranjeUpdateRequest>, IOsiguranjeService
    {
        public OsiguranjeService(eKartonContext context, IMapper mapper)
        : base(context, mapper)
        {
        }

        public override IQueryable<Databases.Osiguranje> AddInclude(IQueryable<Databases.Osiguranje> query, PacijentSearchObject? search = null)
        {
            if (search?.isPreventivneMjereIncluded == true)
            {
                query = query.Include("PreventivneMjeres");
            }
            if (search?.isOsiguranjeInclude == true)
            {
                query = query.Include("PacijentOsiguranjes.Osiguranje");
            }
            return base.AddInclude(query, search);
        }
       /* public override IQueryable<Databases.Osiguranje> AddFilter(IQueryable<Databases.Osiguranje> query, PacijentSearchObject? search = null)
        {
            
        }*/
    }
}
