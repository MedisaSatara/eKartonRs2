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
    public class KategorijaTransakcijaService : BaseCRUDService<Model.Models.KategorijaTransakcija25062025, Databases.KategorijaTransakcija25062025, KategorijaTransakcijaSearchObject, KategorijaTransakcijaInsertRequest, KategorijaTransakcijaUpdateRequest>, IKategorijaTranskacijaService
    {
        public KategorijaTransakcijaService(eKartonContext context, IMapper mapper)
            : base(context, mapper)
        {
        }

        public override IQueryable<Databases.KategorijaTransakcija25062025> AddFilter(IQueryable<Databases.KategorijaTransakcija25062025> query, KategorijaTransakcijaSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.NazivKategorije))
            {
                filteredQuery = filteredQuery.Where(x => x.NazivKategorije.Contains(search.NazivKategorije.ToLower()));
            }
           

            return filteredQuery;
        }

    }
}
