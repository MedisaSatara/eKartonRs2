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
    public class KorisnikUlogaService : BaseCRUDService<Model.Models.KorisnikUloga, Databases.KorisnikUloga, KorisnikUlogaSearchObject, KorisnikUlogaInsertRequest, KorisnikUlogaUpdateRequest>, IKorisnikUlogaService
    {
        public KorisnikUlogaService(eKartonContext context, IMapper mapper)
            : base(context, mapper)
        {
        }

        public override IQueryable<Databases.KorisnikUloga> AddInclude(IQueryable<Databases.KorisnikUloga> query, KorisnikUlogaSearchObject? search = null)
        {
            if (search?.IsUlogaIncluded == true)
            {
                query = query.Include("Uloga");
            }
            return base.AddInclude(query, search);
        }
        public override IQueryable<Databases.KorisnikUloga> AddFilter(IQueryable<Databases.KorisnikUloga> query, KorisnikUlogaSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.ImeKorisnik))
            {
                filteredQuery = filteredQuery.Where(x => x.Korisnik.Ime.Contains(search.ImeKorisnik.ToLower()));
            }
            if (!string.IsNullOrWhiteSpace(search?.PrezimeKorisnika))
            {
                filteredQuery = filteredQuery.Where(x => x.Korisnik.Prezime.Contains(search.PrezimeKorisnika.ToLower()));
            }
            if (!string.IsNullOrWhiteSpace(search?.NazivUloge))
            {
                filteredQuery = filteredQuery.Where(x => x.Uloga.Naziv.Contains(search.NazivUloge.ToLower()));
            }

            return filteredQuery;
        }
    }
}
