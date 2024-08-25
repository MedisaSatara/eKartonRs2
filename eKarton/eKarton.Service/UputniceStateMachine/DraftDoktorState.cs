using AutoMapper;
using EasyNetQ;
using eKarton.Model.Messages;
using eKarton.Model.Request;
using eKarton.Service.Databases;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Service.UputniceStateMachine
{
    public class DraftDoktorState:BaseDoktorState
    {
        public DraftDoktorState(eKartonContext context, IMapper mapper, IServiceProvider serviceProvider) : base(context, mapper, serviceProvider)
        {
        }

        public override async Task<eKarton.Model.Models.Doktor> Update(int id, DoktorUpdateRequest request)
        {
            var set = _context.Set<Databases.Doktor>();

            var entity = set.Find(id);

            _mapper.Map(request, entity);

            await _context.SaveChangesAsync();
            return _mapper.Map<eKarton.Model.Models.Doktor> (entity);

        }

        public override async Task<eKarton.Model.Models.Doktor> Activate(int id)
        {
            var set = _context.Set<Databases.Doktor>();

            var entity = set.Find(id);

            entity.StateMachine = "active";

            await _context.SaveChangesAsync();
            var bus = RabbitHutch.CreateBus("host=localhost:5672");
            var mappedEntity= _mapper.Map<eKarton.Model.Models.Doktor>(entity);
            DoktoriActivated message = new DoktoriActivated { Doktor = mappedEntity };
            bus.PubSub.Publish(message);


            return mappedEntity;
        }

    }
}
