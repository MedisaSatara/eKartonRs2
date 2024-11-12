using AutoMapper;
using eKarton.Model.Request;
using eKarton.Service.Databases;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Service.UputniceStateMachine
{
    public class BaseTerminState
    {
        public eKartonContext _context { get; set; }
        public IMapper _mapper { get; set; }
        public IServiceProvider ServiceProvider { get; set; }

        public BaseTerminState(eKartonContext context, IMapper mapper, IServiceProvider serviceProvider)
        {
            _context = context;
            _mapper = mapper;
            ServiceProvider = serviceProvider;
        }
        public virtual Task<eKarton.Model.Models.Termin> Insert(TerminInsertRequest request)
        {
            throw new Exception("Method not allowed");
        }

        public virtual Task<eKarton.Model.Models.Termin> Update(int id, TerminUpdateRequest request)
        {
            throw new Exception("Method not allowed");
        }

        public virtual Task<eKarton.Model.Models.Termin> Activate(int id)
        {
            throw new Exception("Method not allowed");
        }

        public virtual Task<eKarton.Model.Models.Termin> Hide(int id)
        {
            throw new Exception("Method not allowed");
        }

        public BaseTerminState CreateState(string stateName)
        {
            switch (stateName)
            {
                case "initial":
                    return ServiceProvider.GetService<InitialTerminState>();
                case "draft":
                    return ServiceProvider.GetService<DraftTerminState>();
                case "active":
                    return ServiceProvider.GetService<ActiveTerminState>();
                default: throw new Exception("State not recognized");
            }
        }
        public virtual async Task<List<string>> AllowedActions()
        {
            return new List<string>();
        }
    }
}
