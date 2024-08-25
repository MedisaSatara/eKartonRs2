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
    public class PreventivneMjereService : BaseCRUDService<Model.Models.PreventivneMjere, Databases.PreventivneMjere, PacijentSearchObject, PreventivneMjereInsertRequest, PreventivneMjereUpdateRequest>, IPreventivneMjere
    {
        public PreventivneMjereService(eKartonContext context, IMapper mapper)
        : base(context, mapper)
        {
        }

       /* public override IQueryable<Databases.PreventivneMjere> AddInclude(IQueryable<Databases.PreventivneMjere> query, PacijentSearchObject? search = null)
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
        }*/
        public override IQueryable<Databases.PreventivneMjere> AddFilter(IQueryable<Databases.PreventivneMjere> query, PacijentSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.ImePacijenta))
            {
                filteredQuery = filteredQuery.Where(x => x.Pacijent.Ime == search.ImePacijenta);
            }
            if (!string.IsNullOrWhiteSpace(search?.PrezimePacijenta))
            {
                filteredQuery = filteredQuery.Where(x => x.Pacijent.Prezime == search.PrezimePacijenta);
            }
            if (!string.IsNullOrWhiteSpace(search?.BrojKartona))
            {
                filteredQuery = filteredQuery.Where(x => x.Pacijent.BrojKartona == search.BrojKartona);
            }
            if (search?.isPreventivneMjereIncluded == true)
            {
                query = query.Include(x => x.PreventivneMjereId);
            }


            return filteredQuery;
        }
    }
}
