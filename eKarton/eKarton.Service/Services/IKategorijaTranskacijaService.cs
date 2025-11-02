using eKarton.Model.Request.SearchObject;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Service.Services
{
    public interface IKategorijaTranskacijaService : ICRUDService<Model.Models.KategorijaTransakcija25062025, KategorijaTransakcijaSearchObject, Model.Request.KategorijaTransakcijaInsertRequest, Model.Request.KategorijaTransakcijaUpdateRequest>
    {
    }

}
