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
    public class PregledService : BaseService<Model.Models.Pregled, Databases.Pregled, PacijentClassesSearchObject>, IPregledService
    {
        public PregledService(eKartonContext context, IMapper mapper)
            : base(context, mapper)
        {

        }
        public override IQueryable<Databases.Pregled> AddFilter(IQueryable<Databases.Pregled> query, PacijentClassesSearchObject? search = null)
        {
            if (!string.IsNullOrWhiteSpace(search?.ImePacijenta))
            {
                query = query.Where(x => x.Pacijent.Ime.StartsWith(search.ImePacijenta));
            }
            if (!string.IsNullOrWhiteSpace(search?.PrezimePacijenta))
            {
                query = query.Where(x => x.Pacijent.Prezime.StartsWith(search.PrezimePacijenta));
            }
            if (!string.IsNullOrWhiteSpace(search?.BrojKartona))
            {
                query = query.Where(x => x.Pacijent.BrojKartona == search.BrojKartona);
            }
            if (search?.PacijentId != null && search.PacijentId > 0)
            {
                query = query.Where(x => x.PacijentId == search.PacijentId);
            }

            return base.AddFilter(query, search);
        }
    }
}
