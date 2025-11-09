using AppNotificacoesCrimesCidade.Application.Dtos;
using AppNotificacoesCrimesCidade.Application.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace NotificaCrimesBackEnd.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class TipoBemController : ControllerBase
    {
        private readonly ITipoBemService _service;

        public TipoBemController(ITipoBemService service)
        {
            _service = service;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<TipoBemDto>>> GetAllAsync()
        {
            var entidades = await _service.GetAllAsync();
            return entidades.Map<ActionResult>(
                onSuccess: entidades => Ok(entidades),
                onFailure: entidades => BadRequest(entidades)
               );
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<TipoBemDto>> GetByIdAsync(string id)
        {
            var entidade = await _service.GetByIdAsync(id);
            return entidade.Map<ActionResult>(
                onSuccess: entidade => Ok(entidade),
                onFailure: entidade => BadRequest(entidade)
               );
        }

        [HttpPost]
        public async Task<ActionResult<TipoBemDto>> Post(TipoBemForm form)
        {
            var dto = await _service.AddAsync(form);
            return dto.Map<ActionResult>(
                onSuccess: dto => Ok(dto),
                onFailure: dto => BadRequest(dto)
               );
        }


        [HttpPut("{id}")]
        public async Task<ActionResult<TipoBemDto>> UpdateAsync(TipoBemForm form, string id)
        {
            var entidade = await _service.UpdateAsync(form, id);
            return entidade.Map<ActionResult>(
                onSuccess: entidade => Ok(entidade),
                onFailure: entidade => BadRequest(entidade)
               );
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult<TipoBemDto>> Delete(string id)
        {
            var result = await _service.DeleteAsync(id);

            return result.Map<ActionResult>(
                onSuccess: () => Ok(),
                onFailure: error => BadRequest(error)
            );

        }
    }
}
