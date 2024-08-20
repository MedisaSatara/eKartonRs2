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
    public class DoktorService : BaseService<Model.Models.Doktor, Databases.Doktor, DoktorSearchObject>, IDoktorService
    {
        public DoktorService(eKartonContext context, IMapper mapper)
            : base(context, mapper)
        {

        }
        public override IQueryable<Databases.Doktor> AddFilter(IQueryable<Databases.Doktor> query, DoktorSearchObject? search = null)
        {
            if (!string.IsNullOrWhiteSpace(search?.ImeDoktora))
            {
                query = query.Where(x => x.Ime.StartsWith(search.ImeDoktora));
            }
            if (!string.IsNullOrWhiteSpace(search?.PrezimeDoktora))
            {
                query = query.Where(x => x.Prezime.StartsWith(search.PrezimeDoktora));
            }
            if (!string.IsNullOrWhiteSpace(search?.NazivOdjela))
            {
                query = query.Where(x => x.Odjel.Naziv == search.NazivOdjela);
            }
            if (search?.OdjelId != null && search.OdjelId > 0)
            {
                query = query.Where(x => x.OdjelId == search.OdjelId);
            }

            return base.AddFilter(query, search);
        }



    }
}
