using AutoMapper;
using eKarton.Model.Request;
using eKarton.Service.Databases;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Service.UputniceStateMachine
{
    public class InitialTerminState : BaseTerminState
    {
        public InitialTerminState(eKartonContext context, IMapper mapper, IServiceProvider serviceProvider) : base(context, mapper, serviceProvider)
        {
        }

        public override async Task<eKarton.Model.Models.Termin> Insert(TerminInsertRequest request)
        {
            var set = _context.Set<Databases.Termin>();
            var entity = _mapper.Map<Databases.Termin>(request);
            entity.StateMachine = "draft";
            set.Add(entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<eKarton.Model.Models.Termin>(entity);
        }

    }
}
