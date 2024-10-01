using eKarton.Model;
using eKarton.Service.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eKarton.Controllers
{
    [Route("[controller]")]
    [Authorize]
    public class BaseDoktorController<T, TSearch> : ControllerBase where T : class where TSearch : class
    {
        protected readonly IServiceDoktor<T, TSearch> _service;
        protected readonly ILogger<BaseDoktorController<T, TSearch>> _logger;

        public BaseDoktorController(ILogger<BaseDoktorController<T, TSearch>> logger, IServiceDoktor<T, TSearch> service)
        {
            _logger = logger;
            _service = service;
        }

        [HttpGet]
        public async Task<PagedResult<T>> Get([FromQuery] TSearch search = null)
        {
            return await _service.Get(search);
        }

        [HttpGet("{id}")]
        public async Task<T> GetById(int id)
        {
            return await _service.GetById(id);
        }
    }
}
