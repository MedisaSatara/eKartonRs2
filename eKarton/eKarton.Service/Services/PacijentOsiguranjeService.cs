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
    public class PacijentOsiguranjeService : BaseCRUDService<Model.Models.PacijentOsiguranje, Databases.PacijentOsiguranje, PacijentSearchObject, PacijentOsiguranjeInsertRequest, PacijentOsiguranjeUpdateRequest>, IPacijentOsiguranjeService
    {
        public PacijentOsiguranjeService(eKartonContext context, IMapper mapper)
        : base(context, mapper)
        {
        }

        /*public override IQueryable<Databases.Pacijent> AddInclude(IQueryable<Databases.Pacijent> query, PacijentSearchObject? search = null)
        {
            if (search?.isOsiguranjeInclude == true)
            {
                query = query.Include("PacijentOsiguranjes.Osiguranje");
            }
            return base.AddInclude(query, search);
        }*/
        public override IQueryable<Databases.PacijentOsiguranje> AddFilter(IQueryable<Databases.PacijentOsiguranje> query, PacijentSearchObject? search = null)
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


            return filteredQuery;
        }
    }
}
