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
                query = query.Where(x => x.Ime.StartsWith(search.ImeDoktora));
            }
            if (!string.IsNullOrWhiteSpace(search?.PrezimeDoktora))
            {
                query = query.Where(x => x.Prezime.StartsWith(search.PrezimeDoktora));
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
            lock (isLocked)
            {
                if (mlContext == null)
                {
                    mlContext = new MLContext();

                    // Load data from the database
                    var doktorData = _context.Doktors.Include(d => d.OcjenaDoktors).ToList();

                    var data = new List<DestinationEntry>();

                    // Prepare data for training
                    foreach (var doktor in doktorData)
                    {
                        if (doktor.OcjenaDoktors != null && doktor.OcjenaDoktors.Count > 1)
                        {
                            var doktorUserIDs = doktor.OcjenaDoktors.Select(o => o.KorisnikId).Distinct().ToList();

                            foreach (var userId in doktorUserIDs)
                            {
                                var preporukaDoktora = doktor.OcjenaDoktors
                                    .Where(o => o.KorisnikId != userId)
                                    .ToList();

                                foreach (var preporuceniDoktor in preporukaDoktora)
                                {
                                    data.Add(new DestinationEntry()
                                    {
                                        DestinationID = (uint)doktor.DoktorId,
                                        CoRatedDestinationID = (uint)preporuceniDoktor.DoktorId,
                                        Label = 1 // Rating exists
                                    });
                                }
                            }
                        }
                    }

                    if (!data.Any())
                    {
                        throw new InvalidOperationException("No valid data available for training.");
                    }

                    var traindata = mlContext.Data.LoadFromEnumerable(data);

                    // Set up training options
                    var options = new MatrixFactorizationTrainer.Options
                    {
                        MatrixColumnIndexColumnName = nameof(DestinationEntry.DestinationID),
                        MatrixRowIndexColumnName = nameof(DestinationEntry.CoRatedDestinationID),
                        LabelColumnName = nameof(DestinationEntry.Label),
                        LossFunction = MatrixFactorizationTrainer.LossFunctionType.SquareLossOneClass,
                        Alpha = 0.01,
                        Lambda = 0.025,
                        NumberOfIterations = 100,
                        C = 0.00001
                    };

                    // Train the model
                    var estimator = mlContext.Recommendation().Trainers.MatrixFactorization(options);
                    model = estimator.Fit(traindata);
                }
            }

            // Prediction phase
            var doktori = _context.Doktors.Where(x => x.DoktorId != id).ToList();

            var predictionResult = new List<Tuple<Databases.Doktor, float>>();

            foreach (var doktor in doktori)
            {
                var predictionEngine = mlContext.Model.CreatePredictionEngine<DestinationEntry, CoRatedDestinationPrediction>(model);
                var prediction = predictionEngine.Predict(
                                     new DestinationEntry()
                                     {
                                         DestinationID = (uint)id,
                                         CoRatedDestinationID = (uint)doktor.DoktorId
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


        static MLContext mlContext = null;
        static object isLocked = new object();
        static ITransformer model = null;

        public class CoRatedDestinationPrediction
        {
            public float Score { get; set; }
        }

        public class DestinationEntry
        {
            [KeyType(count: 100)] // Adjust count based on the number of unique IDs
            public uint DestinationID { get; set; }

            [KeyType(count: 100)] // Adjust count based on the number of unique IDs
            public uint CoRatedDestinationID { get; set; }

            public float Label { get; set; }
        }
        public List<Model.Models.Doktor> GetRecommendedDoctors()
        {
            var doktorRatings = _context.OcjenaDoktors
         .GroupBy(o => o.DoktorId)
         .Select(g => new
         {
             DoktorId = g.Key,
             AverageRating = g.Average(o => o.Ocjena.GetValueOrDefault())
         })
         .ToList(); // Execute the query and bring data into memory

            // Log the calculated average ratings
            foreach (var rating in doktorRatings)
            {
                Console.WriteLine($"DoktorId: {rating.DoktorId}, AverageRating: {rating.AverageRating}");
            }

            // Step 2: Retrieve all doctors from the database
            var allDoctors = _context.Doktors.ToList(); // Execute the query and bring data into memory

            // Step 3: Join the average ratings with doctors
            var recommendedDoctors = allDoctors
                .Join(doktorRatings,
                      d => d.DoktorId,
                      r => r.DoktorId,
                      (d, r) => new
                      {
                          Doctor = d,
                          AverageRating = r.AverageRating
                      })
                .OrderByDescending(d => d.AverageRating) // Sort doctors by average rating in descending order
                .Take(5) // Select top 5 doctors
                .Select(d => d.Doctor)
                .ToList();

            // Log the recommended doctors
            foreach (var doctor in recommendedDoctors)
            {
                Console.WriteLine($"DoktorId: {doctor.DoktorId}, Name: {doctor.Ime} {doctor.Prezime}");
            }

            // Step 4: Map entities to the model if needed
            return _mapper.Map<List<Model.Models.Doktor>>(recommendedDoctors);
        }



    }

}
