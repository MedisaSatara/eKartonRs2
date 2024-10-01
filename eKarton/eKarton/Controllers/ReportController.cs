using eKarton.Model.Request.SearchObject;
using eKarton.Service.Report;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eKarton.Controllers
{
    [Route("[controller]")]
    [Authorize]
    public class ReportController : ControllerBase
    {
        private readonly IReportService _reportService;
        public ReportController(IReportService service)
        {
            _reportService = service;
        }
        [HttpGet("pregledi-po-doktoru")]
        public IActionResult GetPreglediPoDoktoru(
            [FromQuery] DateTime? startDate,
            [FromQuery] DateTime? endDate,
            [FromQuery] int? month,
            [FromQuery] int? year)
        {
            var report = _reportService.GetPreglediPoDoktoruReport(startDate, endDate, month, year);
            return Ok(report);
        }
        [HttpGet("bolesti-po-godistu")]
        public IActionResult GetBolestiPoGodistuReport()
        {
            var report = _reportService.GetBolestiPoGodistuReport();
            return Ok(report);
        }
        [HttpGet("top-3-najposjecenija-doktora")]
        public IActionResult GetTop3NajposjecenijaDoktoraReport(DateTime? startDate, DateTime? endDate)
        {
            var report = _reportService.GetTop3NajposjecenijaDoktoraReport(startDate, endDate);
            return Ok(report);
        }

    }
}
