using AutoMapper;
using eKarton.Model.Request;
using eKarton.Model.Request.SearchObject;
using eKarton.Service.Databases;
using eKarton.Service.UputniceStateMachine;
using Microsoft.EntityFrameworkCore;
using Microsoft.ML;
using Microsoft.ML.Data;
using Microsoft.ML.Trainers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Service.Services
{
    public class DoktorService : BaseCRUDDoktorService<Model.Models.Doktor, Databases.Doktor, DoktorSearchObject, DoktorInsertRequest, DoktorUpdateRequest>, IDoktorService
    {
        public BaseDoktorState _baseState { get; set; }

        public DoktorService(BaseDoktorState baseState, eKartonContext context, IMapper mapper)
            : base(context, mapper)
        {
            _baseState = baseState;
        }

        public override IQueryable<Databases.Doktor> AddFilter(IQueryable<Databases.Doktor> query, DoktorSearchObject? search = null)
        {
            if (!string.IsNullOrWhiteSpace(search?.ImeDoktora))
            {
                query = query.Where(x => x.Ime.ToLower().Contains(search.ImeDoktora.ToLower()));
            }
            if (!string.IsNullOrWhiteSpace(search?.PrezimeDoktora))
            {
                query = query.Where(x => x.Prezime.ToLower().Contains(search.PrezimeDoktora.ToLower()));
            }
            if (!string.IsNullOrWhiteSpace(search?.NazivOdjela))
            {
                query = query.Where(x => x.Odjel.Naziv == search.NazivOdjela);
            }
            if (search?.OdjelId != null && search.OdjelId > 0)
            {
                query = query.Where(x => x.OdjelId == search.OdjelId);
            }
            if (search?.IsIncludedOcjena == true)
            {
                query = query.Include(x => x.OcjenaDoktors);
            }

            return base.AddFilter(query, search);
        }


        public override async Task<Model.Models.Doktor> Insert(DoktorInsertRequest insert)
        {
            var state = _baseState.CreateState("initial");
            return await state.Insert(insert);
        }

        public override async Task<Model.Models.Doktor> Update(int id, DoktorUpdateRequest update)
        {
            var entity = await _context.Doktors.FindAsync(id);
            var state = _baseState.CreateState(entity.StateMachine);
            return await state.Update(id, update);
        }

        public async Task<Model.Models.Doktor> Activate(int id)
        {
            var entity = await _context.Doktors.FindAsync(id);
            var state = _baseState.CreateState(entity.StateMachine);
            return await state.Activate(id);
        }

        public async Task<Model.Models.Doktor> Hide(int id)
        {
            var entity = await _context.Doktors.FindAsync(id);
            var state = _baseState.CreateState(entity.StateMachine);
            return await state.Hide(id);
        }

        public List<Model.Models.Doktor> GetPreporuceniDoktor(int id)
        {
            if (mlContext == null)
            {
                lock (isLocked)
                {
                    if (mlContext == null)
                    {
                        mlContext = new MLContext();
                        var tmpData = _context.Doktors.Include(o => o.OcjenaDoktors).ToList();

                        if (!tmpData.Any())
                        {
                            throw new InvalidOperationException("No doktor found in the database.");
                        }

                        var data = new List<DoktorEntry>();

                        foreach (var x in tmpData)
                        {
                            if (x.OcjenaDoktors.Count > 1)
                            {
                                var distinctItemId = x.OcjenaDoktors.Select(y => y.DoktorId).Distinct().ToList();

                                distinctItemId.ForEach(y =>
                                {
                                    var relatedItems = x.OcjenaDoktors.Where(z => z.OcjenaId != y).Select(oi => oi.DoktorId).Distinct();
                                    foreach (var z in relatedItems)
                                    {
                                        data.Add(new DoktorEntry()
                                        {
                                            DoktorId = (uint)y,
                                            CoPurchaseDoktorID = (uint)z,
                                            Label = 1.0f
                                        });
                                    }
                                });
                            }
                        }

                        if (data.Count == 0)
                        {
                            throw new InvalidOperationException("No valid data found for training.");
                        }

                        Console.WriteLine($"Data count: {data.Count}");

                        var traindata = mlContext.Data.LoadFromEnumerable(data);

                        MatrixFactorizationTrainer.Options options = new MatrixFactorizationTrainer.Options
                        {
                            MatrixColumnIndexColumnName = nameof(DoktorEntry.DoktorId),
                            MatrixRowIndexColumnName = nameof(DoktorEntry.CoPurchaseDoktorID),
                            LabelColumnName = nameof(DoktorEntry.Label),
                            LossFunction = MatrixFactorizationTrainer.LossFunctionType.SquareLossOneClass,
                            Alpha = 0.01,
                            Lambda = 0.025,
                            NumberOfIterations = 100,
                            C = 0.00001
                        };

                        var est = mlContext.Recommendation().Trainers.MatrixFactorization(options);
                        model = est.Fit(traindata);
                    }
                }
            }

            var doktors = _context.Doktors.Where(x => x.DoktorId != id);
            var predictionResult = new List<Tuple<Databases.Doktor, float>>();

            var predictionEngine = mlContext.Model.CreatePredictionEngine<DoktorEntry, Copurchase_prediction>(model);

            foreach (var doktor in doktors)
            {
                var prediction = predictionEngine.Predict(
                    new DoktorEntry()
                    {
                        DoktorId = (uint)id,
                        CoPurchaseDoktorID = (uint)doktor.DoktorId,
                    });

                predictionResult.Add(new Tuple<Databases.Doktor, float>(doktor, prediction.Score));
            }

            var finalResult = predictionResult
                .OrderByDescending(x => x.Item2)
                .Select(x => x.Item1)
                .Take(3)
                .ToList();

            return _mapper.Map<List<Model.Models.Doktor>>(finalResult);
        }




        public class Copurchase_prediction
        {
            public float Score { get; set; }
        }

        public class DoktorEntry
        {
            [KeyType(count: 3)]
            public uint DoktorId { get; set; }

            [KeyType(count: 3)]
            public uint CoPurchaseDoktorID { get; set; }

            public float Label { get; set; }
        }



        static MLContext mlContext = null;
        static object isLocked = new object();
        static ITransformer model = null;

        public List<Model.Models.Doktor> GetRecommendedDoctors()
        {
            var doktorRatings = _context.OcjenaDoktors
         .GroupBy(o => o.DoktorId)
         .Select(g => new
         {
             DoktorId = g.Key,
             AverageRating = g.Average(o => o.Ocjena.GetValueOrDefault())
         })
         .ToList();

            foreach (var rating in doktorRatings)
            {
                Console.WriteLine($"DoktorId: {rating.DoktorId}, AverageRating: {rating.AverageRating}");
            }

            var allDoctors = _context.Doktors.ToList(); 

            var recommendedDoctors = allDoctors
                .Join(doktorRatings,
                      d => d.DoktorId,
                      r => r.DoktorId,
                      (d, r) => new Model.Models.Doktor
                      {
                          DoktorId = d.DoktorId,
                          Ime = d.Ime,
                          Prezime = d.Prezime,
                          OdjelId=d.OdjelId,
                          AverageRating = r.AverageRating
                      })
                .OrderByDescending(d => d.AverageRating) 
                .Take(5) 
                .ToList();

            foreach (var doctor in recommendedDoctors)
            {
                Console.WriteLine($"DoktorId: {doctor.DoktorId}, Name: {doctor.Ime} {doctor.Prezime}");
            }

            return _mapper.Map<List<Model.Models.Doktor>>(recommendedDoctors);
        }



    }

}
