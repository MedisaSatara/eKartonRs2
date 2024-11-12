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
using eKarton.Service.UputniceStateMachine;

namespace eKarton.Service.Services
{
    public class TerminService : BaseCRUDService<Model.Models.Termin, Databases.Termin, TerminSearchObject, TerminInsertRequest, TerminUpdateRequest>, ITerminService
    {
        private readonly IMailProducer _mailProducer;
        public BaseTerminState _baseState { get; set; }
        public TerminService(BaseTerminState baseState, IMailProducer mailProducer, eKartonContext context, IMapper mapper)
            : base(context, mapper)
        {
            _mailProducer = mailProducer;
            _baseState = baseState;
        }
        public override void BeforeInsert(TerminInsertRequest insert, Databases.Termin entity)
        {
            entity.Vrijeme = insert.Vrijeme;
            entity.Datum = insert.Datum;
            entity.Razlog = insert.Razlog;
            entity.PacijentId = insert.PacijentId;
            entity.DoktorId = insert.DoktorId;
            entity.StateMachine = insert.StateMachine;

            base.BeforeInsert(insert, entity);

            SendEmailOnTerminInsert(entity.PacijentId, entity.Datum, entity.Vrijeme);
        }

        private void SendEmailOnTerminInsert(int pacijentId, string? datum, string vrijeme)
        {
            var user = _context.Pacijents.Find(pacijentId);
            if (user != null)
            {
               
                var emailMessage = new
                {
                    Sender = "tt8915119@gmail.com", 
                    Recipient = user.Email,         
                    Subject = "Novi Termin Zakazan",
                    Content = $"Poštovani {user.Ime}, vaš termin je zakazan za {datum} u {vrijeme}." 
                };

                _mailProducer.SendEmail(emailMessage);
            }
        }


        public override IQueryable<Databases.Termin> AddFilter(IQueryable<Databases.Termin> query, TerminSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.ImeDoktora))
            {
                filteredQuery = filteredQuery.Where(x => x.Doktor.Ime.Contains(search.ImeDoktora));
            }
            if (!string.IsNullOrWhiteSpace(search?.PrezimeDoktora))
            {
                filteredQuery = filteredQuery.Where(x => x.Doktor.Prezime.Contains(search.PrezimeDoktora));
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
                throw new InvalidOperationException("An error occurred while processing the request.", ex);
            }
        }
        public async Task<eKarton.Model.Models.Termin> Insert(TerminInsertRequest insert)
        {
            var set = _context.Set<Termin>();

            Termin entity = _mapper.Map<Termin>(insert);

            set.Add(entity);
            BeforeInsert(insert, entity);
            var state = _baseState.CreateState("initial");
            var result = await state.Insert(insert);

            await _context.SaveChangesAsync();

            //RabbitMQ: API - objekat - Auxiliary

            var korisnik = entity.Pacijent;
            if (korisnik != null)
            {
                TerminNotifier reservation = new TerminNotifier
                {
                    Email = korisnik.Email,
                    Subject = "Novi termin pregleda",
                    Content = $"Poštovani, \n\nOva poruka potvrđuje da je vaša termin za pregled zakazan uspješno. Za sve dodatne informacije ili ako imate bilo kakvih pitanja, slobodno nas kontaktirajte putem ovog emaila. \n\nLijep pozdrav!"
                };
                _mailProducer.SendEmail(reservation);
            }

            return result;

        }
        public async Task<Model.Models.Termin> Activate(int id)
        {
            var entity = await _context.Termins.FindAsync(id);

            var state = _baseState.CreateState(entity.StateMachine);

            return await state.Activate(id);
        }


        public async Task<List<string>> AllowedActions(int id)
        {
            var entity = await _context.Termins.FindAsync(id);
            var state = _baseState.CreateState(entity?.StateMachine ?? "initial");
            return await state.AllowedActions();
        }






    }
}
