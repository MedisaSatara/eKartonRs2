using eKarton.Service.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eKarton.Controllers
{
    [Route("[controller]")]
    public class BaseCRUDDoktorController<T, TSearch, TInsert, TUpdate> : BaseDoktorController<T, TSearch> where T : class where TSearch : class
    {
        protected new readonly ICRUDDoktoriService<T, TSearch, TInsert, TUpdate> _service;
        protected readonly ILogger<BaseDoktorController<T, TSearch>> _logger;

        public BaseCRUDDoktorController(ILogger<BaseDoktorController<T, TSearch>> logger, ICRUDDoktoriService<T, TSearch, TInsert, TUpdate> service)
            : base(logger, service)
        {
            _logger = logger;
            _service = service;
        }

        [HttpPost]
        public virtual async Task<T> Insert([FromBody] TInsert insert)
        {
            return await _service.Insert(insert);
        }

        [HttpPut("{id}")]
        public virtual async Task<T> Update(int id, [FromBody] TUpdate update)
        {
            return await _service.Update(id, update);
        }
        [HttpDelete("{id}")]
        public virtual async Task<T> Delete(int id)
        {
            return await _service.Delete(id);
        }

    }
}
