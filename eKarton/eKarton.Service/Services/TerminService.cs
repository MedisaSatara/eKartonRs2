using AutoMapper;
using eKarton.Model.Request.SearchObject;
using eKarton.Model.Request;
using eKarton.Service.Databases;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using eKarton.Service.RabbitMQ;

namespace eKarton.Service.Services
{
    public class TerminService : BaseCRUDService<Model.Models.Termin, Databases.Termin, TerminSearchObject, TerminInsertRequest, TerminUpdateRequest>, ITerminService
    {
        private readonly IMailProducer _mailProducer;
        public TerminService(IMailProducer mailProducer, eKartonContext context, IMapper mapper)
            : base(context, mapper)
        {
            _mailProducer = mailProducer;
        }
        public override void BeforeInsert(TerminInsertRequest insert, Databases.Termin entity)
        {
            entity.Vrijeme = insert.Vrijeme;
            entity.Datum = insert.Datum;
            entity.Razlog = insert.Razlog;
            entity.PacijentId = insert.PacijentId;
            entity.DoktorId = insert.DoktorId;

            base.BeforeInsert(insert, entity);

            // Get the patient details for the email
            var user = _context.Pacijents.Find(insert.PacijentId);
            if (user != null)
            {
                var emailMessage = new
                {
                    Sender = "tt8915119@gmail.com", // You can customize this
                    Recipient = user.Email,
                    Subject = "Novi Termin Zakazan",
                    Content = $"Poštovani {user.Ime}, vaš termin je zakazan za {entity.Datum} u {entity.Vrijeme}."
                };

                _mailProducer.SendEmail(emailMessage);
            }
        }


        public override IQueryable<Databases.Termin> AddFilter(IQueryable<Databases.Termin> query, TerminSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.BrojKartona))
            {
                filteredQuery = filteredQuery.Where(x => x.Pacijent.BrojKartona == search.BrojKartona);
            }
            return filteredQuery;
        }

        public async Task AcceptServiceRequest(int terminId)
        {
            try
            {
                var serviceRequest = await _context.Termins.FindAsync(terminId);
                if (serviceRequest == null)
                {
                    throw new InvalidOperationException("Termin request not found");
                }

                if (serviceRequest.Datum == null || serviceRequest.Vrijeme == null)
                {
                    throw new InvalidOperationException("Service request does not have valid date or time information");
                }

                if (serviceRequest.PacijentId == null || serviceRequest.DoktorId == null)
                {
                    throw new InvalidOperationException("PacijentId or DoktorId is null in the termin request.");
                }

                var user = await _context.Pacijents.FindAsync(serviceRequest.PacijentId);
                if (user != null)
                {
                    var emailMessage = new
                    {
                        Sender = "tt8915119@gmail.com",
                        Recipient = user.Email,
                        Subject = "Prihvaćen termin i usluga od šetača!",
                        Content = $"Zakazani termin za {serviceRequest.Datum} je prihvaćen od strane doktora za pregled u vrijeme {serviceRequest.Vrijeme}."
                    };

                    _mailProducer.SendEmail(emailMessage);
                }
            }
            catch (Exception ex)
            {
                // Log the error details for further investigation

                // Optionally rethrow the exception or return a specific error response
                throw new InvalidOperationException("An error occurred while processing the request.", ex);
            }
        }



    }
}
