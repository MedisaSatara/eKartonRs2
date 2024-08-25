using eKarton.Model.Models;
using eKarton.Model.Request;
using eKarton.Model.Request.SearchObject;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Service.Services
{
    public interface IDoktorService : ICRUDDoktoriService<Doktor, DoktorSearchObject, DoktorInsertRequest, DoktorUpdateRequest>
    {
        Task<Doktor> Activate(int id);
        Task<Doktor> Hide(int id);
        List<Model.Models.Doktor> GetPreporuceniDoktor(int id);
        List<Model.Models.Doktor> GetRecommendedDoctors();
       // List<Doktor> RecommendDoctors(int korisnikId);
       // List<Model.Models.Doktor> GetRecommendedDoctorsForUser(int userId);

        // Task<List<string>> AllowedActions(int id);

    }
}
