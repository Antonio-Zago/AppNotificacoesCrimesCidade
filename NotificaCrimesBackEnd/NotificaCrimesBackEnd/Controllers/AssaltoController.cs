using AppNotificacoesCrimesCidade.Application.Dtos;
using AppNotificacoesCrimesCidade.Application.Helpers;
using AppNotificacoesCrimesCidade.Application.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace NotificaCrimesBackEnd.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class AssaltoController : ControllerBase
    {
        private readonly IAssaltoService _service;

        public AssaltoController(IAssaltoService service)
        {
            _service = service;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<AssaltoDto>>> GetAllAsync()
        {
            var entidades = await _service.GetAllAsync();
            return entidades.Map<ActionResult>(
                onSuccess: entidades => Ok(entidades),
                onFailure: entidades => BadRequest(entidades)
               );
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<AssaltoDto>> GetByIdAsync(string id)
        {
            var entidade = await _service.GetByIdAsync(id);
            return entidade.Map<ActionResult>(
               onSuccess: entidade => Ok(entidade),
               onFailure: entidade => BadRequest(entidade)
              );
        }

        [HttpPost]
        public async Task<ActionResult<AssaltoDto>> Post(AssaltoForm form)
        {
            var dto = await _service.AddAsync(form);
            return dto.Map<ActionResult>(
                onSuccess: dto => Ok(dto),
                onFailure: dto => BadRequest(dto)
               );
        }


        [HttpPut("{id}")]
        public async Task<ActionResult<AssaltoDto>> UpdateAsync(AssaltoForm form, string id)
        {
            var entidade = await _service.UpdateAsync(form, id);
            return entidade.Map<ActionResult>(
                onSuccess: entidade => Ok(entidade),
                onFailure: entidade => BadRequest(entidade)
               );
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult<AssaltoDto>> Delete(string id)
        {
            var result = await _service.DeleteAsync(id);

            return result.Map<ActionResult>(
                onSuccess: () => Ok(),
                onFailure: error => BadRequest(error)
            );
        }
    }
}
