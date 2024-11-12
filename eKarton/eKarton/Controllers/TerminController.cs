using eKarton.Model.Request.SearchObject;
using eKarton.Model.Request;
using eKarton.Service.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using eKarton.Model.Models;
using eKarton.Service.RabbitMQ;

namespace eKarton.Controllers
{
    [Route("[controller]")]
    public class TerminController : BaseCRUDController<Model.Models.Termin, TerminSearchObject, TerminInsertRequest, TerminUpdateRequest>
    {
        private readonly ITerminService _service;
        private readonly IMailProducer _mailProducer;
        public TerminController(IMailProducer mailProducer, ILogger<BaseController<Model.Models.Termin, TerminSearchObject>> logger, ITerminService service) : base(logger, service)
        {
            _service = service;
            _mailProducer = mailProducer;
        }

        public override Termin Insert([FromBody] TerminInsertRequest insert)
        {
            return base.Insert(insert);
        }
        /*   [HttpPut("{terminId}/accept")]
           public async Task AcceptServiceRequest(int terminId)
           {
               await _service.AcceptServiceRequest(terminId);
           }*/


        [HttpGet("{id}/allowedActions")]
        public virtual async Task<List<string>> AllowedActions(int id)
        {
            return await (_service as ITerminService).AllowedActions(id);
        }

        public class EmailModel
        {
            public string Sender { get; set; }
            public string Recipient { get; set; }
            public string Subject { get; set; }
            public string Content { get; set; }
        }
       /* [HttpPost("SendConfirmationEmail")]
        public IActionResult SendConfirmationEmail([FromBody] EmailModel emailModel)
        {
            _mailProducer.SendEmail(emailModel);

            Thread.Sleep(TimeSpan.FromSeconds(15));
            return Ok();
        }*/

    }
}
