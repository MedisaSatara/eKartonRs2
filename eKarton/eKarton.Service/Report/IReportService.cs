using eKarton.Model.Request.SearchObject;
using eKarton.Service.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eKarton.Service.Report
{
    public interface IReportService
    {
        List<DoktorPreglediReport> GetPreglediPoDoktoruReport(DateTime? startDate, DateTime? endDate, int? month, int? year);
        List<BolestiPoGodistuReport> GetBolestiPoGodistuReport();
        List<OdabraniDoktori> GetTop3NajposjecenijaDoktoraReport(DateTime? startDate, DateTime? endDate);
    }
}
