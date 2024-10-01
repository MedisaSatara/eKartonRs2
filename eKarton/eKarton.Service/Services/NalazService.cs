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
    public class NalazService : BaseService<Model.Models.Nalaz, Databases.Nalaz, PacijentClassesSearchObject>, INalazService
    {
        public NalazService(eKartonContext context, IMapper mapper)
            : base(context, mapper)
        {

        }
        public override IQueryable<Databases.Nalaz> AddFilter(IQueryable<Databases.Nalaz> query, PacijentClassesSearchObject? search = null)
        {
            if (!string.IsNullOrWhiteSpace(search?.ImePacijenta))
            {
                query = query.Where(x => x.Pacijent.Ime.Contains(search.ImePacijenta.ToLower()));
            }
            if (!string.IsNullOrWhiteSpace(search?.PrezimePacijenta))
            {
                query = query.Where(x => x.Pacijent.Prezime.Contains(search.PrezimePacijenta.ToLower()));
            }
            if (!string.IsNullOrWhiteSpace(search?.BrojKartona))
            {
                query = query.Where(x => x.Pacijent.BrojKartona.Contains(search.BrojKartona.ToLower()));
            }
            if (search?.PacijentId != null && search.PacijentId > 0)
            {
                query = query.Where(x => x.PacijentId == search.PacijentId);
            }

            return base.AddFilter(query, search);
        }
    }
}
