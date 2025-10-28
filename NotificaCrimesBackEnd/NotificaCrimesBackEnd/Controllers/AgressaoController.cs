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
            return Ok(entidades);
        }

        [HttpGet("{id:int}")]
        public async Task<ActionResult<AgressaoDto>> GetByIdAsync(int id)
        {
            var entidade = await _service.GetByIdAsync(id);
            return Ok(entidade);
        }

        [HttpPost]
        public async Task<ActionResult<AgressaoDto>> Post(AgressaoForm form)
        {
            var dto = await _service.AddAsync(form);
            return Ok(dto);
        }


        [HttpPut("{id:int}")]
        public async Task<ActionResult<AgressaoDto>> UpdateAsync(AgressaoForm form, int id)
        {
            var entidade = await _service.UpdateAsync(form, id);
            return Ok(entidade);
        }

        [HttpDelete("{id:int}")]
        public async Task<ActionResult<AgressaoDto>> Delete(int id)
        {
            await _service.DeleteAsync(id);

            return Ok();
        }
    }
}
