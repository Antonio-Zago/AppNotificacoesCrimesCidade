using AppNotificacoesCrimesCidade.Application.Dtos;
using AppNotificacoesCrimesCidade.Application.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace NotificaCrimesBackEnd.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class TipoArmaController : ControllerBase
    {
        private readonly ITipoArmaService _service;

        public TipoArmaController(ITipoArmaService service)
        {
            _service = service;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<TipoArmaDto>>> GetAllAsync()
        {
            var entidades = await _service.GetAllAsync();
            return entidades.Map<ActionResult>(
                onSuccess: entidades => Ok(entidades),
                onFailure: entidades => BadRequest(entidades)
               );
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<TipoArmaDto>> GetByIdAsync(string id)
        {
            var entidade = await _service.GetByIdAsync(id);
            return entidade.Map<ActionResult>(
               onSuccess: entidade => Ok(entidade),
               onFailure: entidade => BadRequest(entidade)
              );
        }

        [HttpPost]
        public async Task<ActionResult<TipoArmaDto>> Post(TipoArmaForm form)
        {
            var dto = await _service.AddAsync(form);
            return dto.Map<ActionResult>(
                onSuccess: dto => Ok(dto),
                onFailure: dto => BadRequest(dto)
               );
        }


        [HttpPut("{id}")]
        public async Task<ActionResult<TipoArmaDto>> UpdateAsync(TipoArmaForm form, string id)
        {
            var entidade = await _service.UpdateAsync(form, id);
            return entidade.Map<ActionResult>(
                onSuccess: entidade => Ok(entidade),
                onFailure: entidade => BadRequest(entidade)
               );
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult<TipoArmaDto>> Delete(string id)
        {
            var result = await _service.DeleteAsync(id);

            return result.Map<ActionResult>(
                onSuccess: () => Ok(),
                onFailure: error => BadRequest(error)
            );
        }
    }
}
