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
    public class TerminService : BaseCRUDService<Model.Models.Termin, Databases.Termin, TerminSearchObject, TerminInsertRequest, TerminUpdateRequest>, ITerminService
    {
        public TerminService(eKartonContext context, IMapper mapper)
            : base(context, mapper)
        {
        }
        public override void BeforeInsert(TerminInsertRequest insert, Databases.Termin entity)
        {
            entity.Vrijeme = insert.Vrijeme;
            entity.Datum = insert.Datum;
            entity.Razlog = insert.Razlog;
            entity.PacijentId = insert.PacijentId;
            entity.DoktorId = insert.DoktorId;
            base.BeforeInsert(insert, entity);
        }
        
        public override IQueryable<Databases.Termin> AddFilter(IQueryable<Databases.Termin> query, TerminSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.BrojKartona))
            {
                filteredQuery = filteredQuery.Where(x => x.Pacijent.BrojKartona == search.BrojKartona);
            }
            return filteredQuery;
        }

    }
}
