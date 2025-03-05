using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Service.Services
{
    public interface ICRUDDoktoriService<T, TSearch, TInsert, TUpdate> : IServiceDoktor<T, TSearch> where TSearch : class
    {
        List<Model.Models.Doktor> GetPreporuceniDoktor(int id);
        List<Model.Models.Doktor> GetRecommendedDoctors();
        Task<T> Insert(TInsert insert);
        Task<T> Update(int id, TUpdate update);
        Task<T> Delete(int id);
    }
}
