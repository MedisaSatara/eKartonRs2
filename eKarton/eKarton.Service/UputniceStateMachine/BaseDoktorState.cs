using AutoMapper;
using eKarton.Model.Models;
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
    public class BaseDoktorState
    {
        public eKartonContext _context { get; set; }
        public IMapper _mapper { get; set; }
        public IServiceProvider ServiceProvider { get; set; }

        public BaseDoktorState(eKartonContext context, IMapper mapper, IServiceProvider serviceProvider)
        {
            _context = context;
            _mapper = mapper;
            ServiceProvider = serviceProvider;
        }
        public virtual Task<eKarton.Model.Models.Doktor> Insert(DoktorInsertRequest request)
        {
            throw new Exception("Method not allowed");
        }

        public virtual Task<eKarton.Model.Models.Doktor> Update(int id, DoktorUpdateRequest request)
        {
            throw new Exception("Method not allowed");
        }

        public virtual Task<eKarton.Model.Models.Doktor> Activate(int id)
        {
            throw new Exception("Method not allowed");
        }

        public virtual Task<eKarton.Model.Models.Doktor> Hide(int id)
        {
            throw new Exception("Method not allowed");
        }

        public BaseDoktorState CreateState(string stateName)
        {
            switch (stateName)
            {
                case "initial":
                    return ServiceProvider.GetService<InitialDoktorState>();
                case "draft":
                    return ServiceProvider.GetService<DraftDoktorState>();
                case "active":
                    return ServiceProvider.GetService<ActiveDoktorState>();
                default: throw new Exception("State not recognized");
            }
        }
        public virtual async Task<List<string>> AllowedActions()
        {
            return new List<string>();
        }
    }
}
