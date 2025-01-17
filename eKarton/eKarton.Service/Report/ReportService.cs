using AutoMapper;
using eKarton.Model.Request.SearchObject;
using eKarton.Service.Databases;
using eKarton.Service.Services;
using Microsoft.EntityFrameworkCore;
using Raven.Client.Documents.Linq.Indexing;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Service.Report
{
    public class ReportService:IReportService
    {

        private readonly eKartonContext _context; 

        public ReportService(eKartonContext context)
        {
            _context = context;
        }

        public List<DoktorPreglediReport> GetPreglediPoDoktoruReport(DateTime? startDate, DateTime? endDate,int? month, int? year)
        {
            var query = _context.Pregleds
                  .Where(p =>
                      (!startDate.HasValue || p.Datum >= startDate) &&
                      (!endDate.HasValue || p.Datum <= endDate)&&

                    (!month.HasValue || (p.Datum.HasValue && p.Datum.Value.Month == month.Value)) &&

                    (!year.HasValue || (p.Datum.HasValue && p.Datum.Value.Year == year.Value))
                  )
                  .GroupBy(p => new { p.Doktor.DoktorId, p.Doktor.Ime, p.Doktor.Odjel.Naziv })
                  .Select(g => new DoktorPreglediReport
                  {
                      ImeDoktora = g.Key.Ime,
                      Specijalizacija = g.Key.Naziv,
                      BrojPregleda = g.Count(),
                      BrojPacijenata = g.Select(p => p.Pacijent.PacijentId).Distinct().Count()
                  })
                  .ToList();

            return query;
        }

        public List<BolestiPoGodistuReport> GetBolestiPoGodistuReport()
        {
            var currentDate = DateTime.Now;

            var pregledi = _context.Pregleds
                .Include(p => p.Pacijent)  
                .Where(p => p.Pacijent != null && p.Pacijent.DatumRodjenja.HasValue)  
                .ToList();

            var report = pregledi
                .GroupBy(p =>
                {
                    var age = currentDate.Year - p.Pacijent.DatumRodjenja.Value.Year;

                    if (currentDate < p.Pacijent.DatumRodjenja.Value.AddYears(age))
                    {
                        age--;
                    }

                    return (age / 10) * 10;  // Grupisanje po dekadama (npr. 20-29, 30-39)
                })
                .Select(g => new BolestiPoGodistuReport
                {
                    Decade = $"{g.Key}-{g.Key + 9}",  
                    NajcesceBolesti = g.GroupBy(p => p.Dijagnoza) 
                        .Select(d => new BolestStatistika
                        {
                            Dijagnoza = d.Key,
                            BrojPacijenata = d.Select(p => p.Pacijent.PacijentId).Distinct().Count()  
                        })
                        .OrderByDescending(d => d.BrojPacijenata)  
                        .ToList()
                })
                .ToList();

            return report;
        }
        public List<OdabraniDoktori> GetTop3NajposjecenijaDoktoraReport(DateTime? startDate, DateTime? endDate)
        {
            var query = _context.Termins
                .Where(t =>
                    (!startDate.HasValue || DateTime.Parse(t.Datum) >= startDate) && 
                    (!endDate.HasValue || DateTime.Parse(t.Datum) <= endDate))      
                .GroupBy(t => new { t.Doktor.DoktorId, t.Doktor.Ime, t.Doktor.Odjel.Naziv, t.Doktor.Prezime,t.Doktor.Telefon, t.Doktor.DatumRodjenja, t.Doktor.Email })
                .Select(g => new
                {
                    DoktorId = g.Key.DoktorId,
                    ImeDoktora = g.Key.Ime,
                    PrezimeDoktora=g.Key.Prezime,
                    DatumRodjenja=g.Key.DatumRodjenja,
                    Telefon=g.Key.Telefon,
                    Email=g.Key.Email,
                    Specijalizacija = g.Key.Naziv,
                    BrojZakazanihTermina = g.Count(),
                })
                .OrderByDescending(d => d.BrojZakazanihTermina) 
                .Take(3) 
                .ToList();

            return query.Select(d => new OdabraniDoktori
            {
                ImeDoktora = d.ImeDoktora,
                PrezimeDoktora=d.PrezimeDoktora,
                DatumRodjenja=d.DatumRodjenja,
                Telefon=d.Telefon,  Email=d.Email,
                Specijalizacija = d.Specijalizacija,
                BrojZakazanihTermina = d.BrojZakazanihTermina
            }).ToList();
        }


    }
}
