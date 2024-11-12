using AutoMapper;
using eKarton.Service.Databases;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Service.UputniceStateMachine
{
    public class ActiveTerminState : BaseTerminState
    {
        public ActiveTerminState(eKartonContext context, IMapper mapper, IServiceProvider serviceProvider) : base(context, mapper, serviceProvider)
        {
        }
    }
}
