using AppNotificacoesCrimesCidade.Application.Dtos;
using AppNotificacoesCrimesCidade.Application.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace NotificaCrimesBackEnd.Controllers
{
    [Authorize]
    [Route("[controller]")]
    [ApiController]
    public class LocalController : ControllerBase
    {
        private readonly ILocalService _service;

        public LocalController(ILocalService service)
        {
            _service = service;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<LocalDto>>> GetAllAsync()
        {
            var entidades = await _service.GetAllAsync();
            return entidades.Map<ActionResult>(
                onSuccess: entidades => Ok(entidades),
                onFailure: entidades => BadRequest(entidades)
               );
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<LocalDto>> GetByIdAsync(string id)
        {
            var entidade = await _service.GetByIdAsync(id);
            return entidade.Map<ActionResult>(
                onSuccess: entidade => Ok(entidade),
                onFailure: entidade => BadRequest(entidade)
               );
        }

        [HttpGet("by-email/{email}")]
        public async Task<ActionResult<LocalDto>> GetAllByEmail(string email)
        {
            var entidades = await _service.GetAllByEmail(email);
            return entidades.Map<ActionResult>(
                onSuccess: entidades => Ok(entidades),
                onFailure: entidades => BadRequest(entidades)
               );
        }

        [HttpPost]
        public async Task<ActionResult<LocalDto>> Post(LocalForm form)
        {
            var dto = await _service.AddAsync(form);
            return dto.Map<ActionResult>(
                onSuccess: dto => Ok(dto),
                onFailure: dto => BadRequest(dto)
               );
        }


        [HttpPut("{id}")]
        public async Task<ActionResult<LocalDto>> UpdateAsync(LocalForm form, string id)
        {
            var entidade = await _service.UpdateAsync(form, id);
            return entidade.Map<ActionResult>(
                onSuccess: entidade => Ok(entidade),
                onFailure: entidade => BadRequest(entidade)
               );
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult<LocalDto>> Delete(string id)
        {
            var result = await _service.DeleteAsync(id);

            return result.Map<ActionResult>(
                onSuccess: () => Ok(),
                onFailure: error => BadRequest(error)
            );

        }
    }
}
