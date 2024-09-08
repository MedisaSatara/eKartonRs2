using AutoMapper;
using eKarton.Model.Request.SearchObject;
using eKarton.Service.Databases;
using eKarton.Service.Services;
using Microsoft.EntityFrameworkCore;
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
                      // Filtriranje po opsegu datuma
                      (!startDate.HasValue || p.Datum >= startDate) &&
                      (!endDate.HasValue || p.Datum <= endDate)&&

                    // Filtriranje po mjesecu ako je zadano
                    (!month.HasValue || (p.Datum.HasValue && p.Datum.Value.Month == month.Value)) &&

                    // Filtriranje po godini ako je zadano
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

            // Učitaj sve preglede koji uključuju pacijente sa datim datumom rođenja
            var pregledi = _context.Pregleds
                .Include(p => p.Pacijent)  // Učitaj povezane pacijente
                .Where(p => p.Pacijent != null && p.Pacijent.DatumRodjenja.HasValue)  // Filtriraj da pacijent i datum rođenja postoje
                .ToList();

            // Grupisanje po dekadama na osnovu starosti pacijenta
            var report = pregledi
                .GroupBy(p =>
                {
                    var age = currentDate.Year - p.Pacijent.DatumRodjenja.Value.Year;

                    // Umanji starost ako pacijent nije još proslavio rođendan ove godine
                    if (currentDate < p.Pacijent.DatumRodjenja.Value.AddYears(age))
                    {
                        age--;
                    }

                    return (age / 10) * 10;  // Grupisanje po dekadama (npr. 20-29, 30-39)
                })
                .Select(g => new BolestiPoGodistuReport
                {
                    Decade = $"{g.Key}-{g.Key + 9}",  // Prikaz dekade
                    NajcesceBolesti = g.GroupBy(p => p.Dijagnoza)  // Grupisanje po dijagnozi (bolesti)
                        .Select(d => new BolestStatistika
                        {
                            Dijagnoza = d.Key,
                            BrojPacijenata = d.Select(p => p.Pacijent.PacijentId).Distinct().Count()  // Broj različitih pacijenata po dijagnozi
                        })
                        .OrderByDescending(d => d.BrojPacijenata)  // Sortiraj po broju pacijenata
                        .ToList()
                })
                .ToList();

            return report;
        }
        public List<OdabraniDoktori> GetTop3NajposjecenijaDoktoraReport(DateTime? startDate, DateTime? endDate)
        {
            var query = _context.Termins
                .Where(t =>
                    (!startDate.HasValue || DateTime.Parse(t.Datum) >= startDate) && // Filtriranje po početnom datumu
                    (!endDate.HasValue || DateTime.Parse(t.Datum) <= endDate))       // Filtriranje po krajnjem datumu
                .GroupBy(t => new { t.Doktor.DoktorId, t.Doktor.Ime, t.Doktor.Odjel.Naziv })
                .Select(g => new
                {
                    DoktorId = g.Key.DoktorId,
                    ImeDoktora = g.Key.Ime,
                    Specijalizacija = g.Key.Naziv,
                    BrojZakazanihTermina = g.Count()
                })
                .OrderByDescending(d => d.BrojZakazanihTermina) // Sortiramo po broju zakazanih termina
                .Take(3) // Uzimamo samo top 3 doktora
                .ToList();

            return query.Select(d => new OdabraniDoktori
            {
                ImeDoktora = d.ImeDoktora,
                Specijalizacija = d.Specijalizacija,
                BrojZakazanihTermina = d.BrojZakazanihTermina
            }).ToList();
        }


    }
}
