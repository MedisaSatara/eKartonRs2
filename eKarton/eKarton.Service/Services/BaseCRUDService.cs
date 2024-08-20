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
    public class BaseCRUDService<T, TDb, TSearch, TInsert, TUpdate> : BaseService<T, TDb, TSearch>, ICRUDService<T, TSearch, TInsert, TUpdate>
        where T : class where TDb : class where TSearch : BaseSearchObject where TInsert : class where TUpdate : class
    {
        public BaseCRUDService(eKartonContext eContext, IMapper mapper) : base(eContext, mapper)
        {
        }

        public virtual T Insert(TInsert insert)
        {
            var set = _context.Set<TDb>();
            TDb entity = _mapper.Map<TDb>(insert);
            set.Add(entity);
            BeforeInsert(insert, entity);
            _context.SaveChanges();
            return _mapper.Map<T>(entity);
        }

        public virtual void BeforeInsert(TInsert insert, TDb entity)
        {

        }


        public virtual T Update(int id, TUpdate update)
        {
            var set = _context.Set<TDb>();
            var entity = set.Find(id);
            if (entity != null)
            {
                _mapper.Map(update, entity);
            }
            else
            {
                return null;
            }
            _context.SaveChanges();
            return _mapper.Map<T>(entity);
        }
        public virtual T Delete(int id)
        {
            var set = _context.Set<TDb>();
            var entity = set.Find(id);
            if (entity != null)
            {
                var tmp = entity;
                _context.Remove(entity);
                int result = _context.SaveChanges(); // Dodajte ovaj red za proveru rezultata brisanja
                Console.WriteLine($"Delete result: {result}"); // Dodajte ovaj red za proveru rezultata brisanja
                return _mapper.Map<T>(tmp);
            }
            else
            {
                return null;
            }
        }



    }
}
