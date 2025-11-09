using AppNotificacoesCrimesCidade.Application.Dtos;
using AppNotificacoesCrimesCidade.Application.Interfaces;
using AppNotificacoesCrimesCidade.Domain.Entities;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;

namespace NotificaCrimesBackEnd.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class AgressaoController : ControllerBase
    {
        private readonly IAgressaoService _service;

        public AgressaoController(IAgressaoService service)
        {
            _service = service;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<AgressaoDto>>> GetAllAsync() 
        { 
            var entidades = await _service.GetAllAsync();
            return entidades.Map<ActionResult>( 
                onSuccess : entidades => Ok(entidades),
                onFailure : entidades => BadRequest(entidades)
               );
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<AgressaoDto>> GetByIdAsync(string id)
        {
            var entidade = await _service.GetByIdAsync(id);
            return entidade.Map<ActionResult>(
                onSuccess: entidade => Ok(entidade),
                onFailure: entidade => BadRequest(entidade)
               );
        }

        [HttpPost]
        public async Task<ActionResult<AgressaoDto>> Post(AgressaoForm form)
        {
            var dto = await _service.AddAsync(form);
            return dto.Map<ActionResult>(
                onSuccess: dto => Ok(dto),
                onFailure: dto => BadRequest(dto)
               );
        }


        [HttpPut("{id}")]
        public async Task<ActionResult<AgressaoDto>> UpdateAsync(AgressaoForm form, string id)
        {
            var entidade = await _service.UpdateAsync(form, id);
            return entidade.Map<ActionResult>(
                onSuccess: entidade => Ok(entidade),
                onFailure: entidade => BadRequest(entidade)
               );
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult<AgressaoDto>> Delete(string id)
        {
            var result = await _service.DeleteAsync(id);

            return result.Map<ActionResult>(
                onSuccess: () => Ok(),
                onFailure: error => BadRequest(error)
            );

        }
    }
}
