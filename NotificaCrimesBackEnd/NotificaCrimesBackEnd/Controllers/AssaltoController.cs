using AppNotificacoesCrimesCidade.Application.Dtos;
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
            return Ok(entidades);
        }

        [HttpGet("{id:int}")]
        public async Task<ActionResult<AssaltoDto>> GetByIdAsync(int id)
        {
            var entidade = await _service.GetByIdAsync(id);
            return Ok(entidade);
        }

        [HttpPost]
        public async Task<ActionResult<AssaltoDto>> Post(AssaltoForm form)
        {
            var dto = await _service.AddAsync(form);
            return Ok(dto);
        }


        [HttpPut("{id:int}")]
        public async Task<ActionResult<AssaltoDto>> UpdateAsync(AssaltoForm form, int id)
        {
            var entidade = await _service.UpdateAsync(form, id);
            return Ok(entidade);
        }

        [HttpDelete("{id:int}")]
        public async Task<ActionResult<AssaltoDto>> Delete(int id)
        {
            await _service.DeleteAsync(id);

            return Ok();
        }
    }
}
