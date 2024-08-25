using AutoMapper;
using eKarton.Model.Request;
using eKarton.Model.Request.SearchObject;
using eKarton.Service.Databases;
using eKarton.Service.UputniceStateMachine;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Service.Services
{
    public class UputnicaService : BaseCRUDService<Model.Models.Uputnica, Databases.Uputnica, BaseSearchObject, UputnicaInsertRequest, UputnicaUpdateRequest>, IUputnicaService
    {
        public BaseDoktorState _baseUputnicaState { get; set; }
        public UputnicaService(eKartonContext context, IMapper mapper)
            : base(context, mapper)
        {
           // _baseUputnicaState=baseUputnicaState;
        }
        
    }

}
