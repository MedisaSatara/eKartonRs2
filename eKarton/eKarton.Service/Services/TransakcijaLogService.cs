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
    public class TransakcijaLogService : BaseCRUDService<Model.Models.TransakcijaLog25062025, Databases.TransakcijaLog25062025, TransakcijaLogSearchObject, TransakcijaLogInsertRequest, TranskacijaLogUpdateRequest>, ITransakcijaLogService
    {
        public TransakcijaLogService(eKartonContext context, IMapper mapper)
            : base(context, mapper)
        {
        }

        public override IQueryable<Databases.TransakcijaLog25062025> AddFilter(IQueryable<Databases.TransakcijaLog25062025> query, TransakcijaLogSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.KorisnikIme))
            {
                filteredQuery = filteredQuery.Where(x => x.Korisnik.Ime.Contains(search.KorisnikIme.ToLower()));
            }


            return filteredQuery;
        }

    }
}
