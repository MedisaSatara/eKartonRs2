using AutoMapper;
using eKarton.Model.Request;
using eKarton.Model.Request.SearchObject;
using eKarton.Service.Databases;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Service.Services
{
    public class PacijentService : BaseCRUDService<Model.Models.Pacijent, Databases.Pacijent, PacijentSearchObject, PacijentInsertRequest, PacijentUpdateRequest>, IPacijentService
    {
        public PacijentService(eKartonContext context, IMapper mapper)
        : base(context, mapper)
        {
        }

        public override IQueryable<Databases.Pacijent> AddInclude(IQueryable<Databases.Pacijent> query, PacijentSearchObject? search = null)
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
        }
        public override IQueryable<Databases.Pacijent> AddFilter(IQueryable<Databases.Pacijent> query, PacijentSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.ImePacijenta))
            {
                filteredQuery = filteredQuery.Where(x => x.Ime == search.ImePacijenta);
            }
            if (!string.IsNullOrWhiteSpace(search?.PrezimePacijenta))
            {
                filteredQuery = filteredQuery.Where(x => x.Prezime == search.PrezimePacijenta);
            }
            if (!string.IsNullOrWhiteSpace(search?.BrojKartona))
            {
                filteredQuery = filteredQuery.Where(x => x.BrojKartona == search.BrojKartona);
            }
            if (search?.isPreventivneMjereIncluded == true)
            {
                query = query.Include(x => x.PreventivneMjeres);
            }


            return filteredQuery;
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
    }
}
