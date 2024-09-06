using AutoMapper;
using eKarton.Model.Request.SearchObject;
using eKarton.Model.Request;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using eKarton.Service.Databases;
using eKarton.Model.Models;
using Microsoft.EntityFrameworkCore;

namespace eKarton.Service.Services
{
    public class KorisnikService : BaseCRUDService<Model.Models.Korisnik, Databases.Korisnik, KorisnikSearchObject, KorisnikInsertRequest, KorisnikUpdateRequest>, IKorisnikService
    {
        public KorisnikService(eKartonContext context, IMapper mapper)
            : base(context, mapper)
        {
        }
        public override void BeforeInsert(KorisnikInsertRequest insert, Databases.Korisnik entity)
        {
            var salt = GenerateSalt();
            entity.LozinkaSalt = salt;
            entity.LozinkaHash = GenerateHash(salt, insert.Password);
            entity.KorisnickoIme = insert.KorisnickoIme;
            if (_context.Korisniks.Any(k => k.KorisnickoIme == insert.KorisnickoIme))
            {
                throw new Model.ConflictException("User with that username already exists");
            }
            //entity.Uloga = insert.UlogaId;
            base.BeforeInsert(insert, entity);
        }
        public static string GenerateSalt()
        {
            RNGCryptoServiceProvider provider = new RNGCryptoServiceProvider();
            var byteArray = new byte[16];
            provider.GetBytes(byteArray);


            return Convert.ToBase64String(byteArray);
        }
        public static string GenerateHash(string salt, string password)
        {
            byte[] src = Convert.FromBase64String(salt);
            byte[] bytes = Encoding.Unicode.GetBytes(password);
            byte[] dst = new byte[src.Length + bytes.Length];

            System.Buffer.BlockCopy(src, 0, dst, 0, src.Length);
            System.Buffer.BlockCopy(bytes, 0, dst, src.Length, bytes.Length);

            HashAlgorithm algorithm = HashAlgorithm.Create("SHA1");
            byte[] inArray = algorithm.ComputeHash(dst);
            return Convert.ToBase64String(inArray);
        }
        public override IQueryable<Databases.Korisnik> AddInclude(IQueryable<Databases.Korisnik> query, KorisnikSearchObject? search = null)
        {
            if (search?.IsUlogeIncluded == true)
            {
                query = query.Include("Uloga");
            }
            return base.AddInclude(query, search);
        }
        public override IQueryable<Databases.Korisnik> AddFilter(IQueryable<Databases.Korisnik> query, KorisnikSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.Ime))
            {
                filteredQuery = filteredQuery.Where(x => x.Ime == search.Ime);
            }
            if (!string.IsNullOrWhiteSpace(search?.Prezime))
            {
                filteredQuery = filteredQuery.Where(x => x.Prezime == search.Prezime);
            }
            if (!string.IsNullOrWhiteSpace(search?.KorisnickoIme))
            {
                filteredQuery = filteredQuery.Where(x => x.KorisnickoIme == search.KorisnickoIme);
            }

            return filteredQuery;
        }

        public Model.Models.Korisnik Login(string username, string password)
        {
            var entity = _context.Korisniks.Include(x=>x.KorisnikUlogas).ThenInclude(y=>y.Uloga).FirstOrDefault(x => x.KorisnickoIme == username);

            if (entity == null)
            {
                return null;
            }
            var hash = GenerateHash(entity.LozinkaSalt, password);

            if (hash != entity.LozinkaHash)
            {
                return null;
            }
            return this._mapper.Map<Model.Models.Korisnik>(entity);
        }

    }
}
