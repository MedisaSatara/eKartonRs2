﻿using AutoMapper;
using eKarton.Model.Request.SearchObject;
using eKarton.Service.Databases;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Service.Services
{
    public class BaseCRUDDoktorService<T, TDb, TSearch, TInsert, TUpdate> : BaseDoktorService<T, TDb, TSearch> where TDb : class where T : class where TSearch : BaseSearchObject
    {
        public BaseCRUDDoktorService(eKartonContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public virtual async Task BeforeInsert(TDb entity, TInsert insert)
        {

        }

        public virtual async Task<T> Insert(TInsert insert)
        {
            var set = _context.Set<TDb>();

            TDb entity = _mapper.Map<TDb>(insert);

            set.Add(entity);
            await BeforeInsert(entity, insert);

            await _context.SaveChangesAsync();
            return _mapper.Map<T>(entity);
        }


        public virtual async Task<T> Update(int id, TUpdate update)
        {
            var set = _context.Set<TDb>();

            var entity = await set.FindAsync(id);

            _mapper.Map(update, entity);

            await _context.SaveChangesAsync();
            return _mapper.Map<T>(entity);
        }
        public virtual async Task<T> Delete(int id)
        {
            var set = _context.Set<TDb>();
            var entity = await set.FindAsync(id);
            var tmp = entity;
            if (entity != null)
                _context.Remove(entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<T>(tmp);

        }
    }
}
