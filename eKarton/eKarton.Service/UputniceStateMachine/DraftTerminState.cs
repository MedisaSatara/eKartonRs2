using AutoMapper;
using EasyNetQ;
using eKarton.Model.Messages;
using eKarton.Model.Request;
using eKarton.Service.Databases;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Service.UputniceStateMachine
{
    public class DraftTerminState : BaseTerminState
    {
        public DraftTerminState(eKartonContext context, IMapper mapper, IServiceProvider serviceProvider) : base(context, mapper, serviceProvider)
        {
        }

        public override async Task<eKarton.Model.Models.Termin> Update(int id, TerminUpdateRequest request)
        {
            var set = _context.Set<Databases.Termin>();

            var entity = set.Find(id);

            _mapper.Map(request, entity);

            await _context.SaveChangesAsync();
            return _mapper.Map<eKarton.Model.Models.Termin>(entity);

        }

        public override async Task<eKarton.Model.Models.Termin> Activate(int id)
        {
            var set = _context.Set<Databases.Termin>();

            var entity = set.Find(id);

            entity.StateMachine = "active";

            await _context.SaveChangesAsync();
            var bus = RabbitHutch.CreateBus("host=localhost:5672");
            var mappedEntity = _mapper.Map<eKarton.Model.Models.Termin>(entity);
            TerminActivated message = new TerminActivated { Termin = mappedEntity };
            bus.PubSub.Publish(message);


            return mappedEntity;
        }

    }
}
