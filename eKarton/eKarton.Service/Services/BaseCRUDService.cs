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
                if (typeof(TDb) == typeof(Korisnik)) 
                {
                    var relatedKorisnikUlogas = _context.Set<KorisnikUloga>()
                                                         .Where(ku => ku.KorisnikId == id)
                                                         .ToList();

                    foreach (var korisnikUloga in relatedKorisnikUlogas)
                    {
                        _context.Set<KorisnikUloga>().Remove(korisnikUloga);  
                    }
                }

                if (typeof(TDb) == typeof(Doktor))
                {
                    var relatedDoktori = _context.Doktors.Where(d => d.OdjelId == id).ToList();

                    if (relatedDoktori.Any())
                    {
                        foreach (var doktor in relatedDoktori)
                        {
                            doktor.OdjelId = null;  
                        }

                        _context.SaveChanges();
                    }
                }

                _context.Remove(entity);

                int result = _context.SaveChanges();
                Console.WriteLine($"Delete result: {result}");

                return _mapper.Map<T>(entity); 
            }
            else
            {
                return null;  
            }
        }



    }
}
