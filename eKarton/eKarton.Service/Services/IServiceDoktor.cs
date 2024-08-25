using eKarton.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Service.Services
{
    public interface IServiceDoktor<T, TSearch> where TSearch : class
    {
       /* IEnumerable<T> Get(TSearch search = null);
        Task<T> GetById(int id);*/
       Task<PagedResult<T>> Get(TSearch search = null);
        Task<T> GetById(int id);
    }
}
