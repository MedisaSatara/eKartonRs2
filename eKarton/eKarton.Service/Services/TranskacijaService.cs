using AutoMapper;
using eKarton.Model.Request.SearchObject;
using eKarton.Model.Request;
using eKarton.Service.Databases;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Service.Services
{
    public class TranskacijaService : BaseCRUDService<Model.Models.Transakcije25062025, Databases.Transakcije25062025, TransakcijaSearchObject, TransakcijaInsertRequest, TransakcijaUpdateRequest>, ITransakcijaService
    {
        public TranskacijaService(eKartonContext context, IMapper mapper)
            : base(context, mapper)
        {
        }

        public override IQueryable<Databases.Transakcije25062025> AddFilter(IQueryable<Databases.Transakcije25062025> query, TransakcijaSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.Status))
            {
                filteredQuery = filteredQuery.Where(x => x.Status.Contains(search.Status.ToLower()));
            }
            if (!string.IsNullOrWhiteSpace(search?.NazivKategorije))
            {
                filteredQuery = filteredQuery.Where(x => x.KategorijaTransakcija.NazivKategorije.Contains(search.NazivKategorije.ToLower()));
            }
            if (!string.IsNullOrWhiteSpace(search?.DatumTransakcije))
            {
                filteredQuery = filteredQuery.Where(x => x.DatumTransakcije.ToString().Contains(search.DatumTransakcije.ToLower()));
            }


            return filteredQuery;
        }
        

    }
}
