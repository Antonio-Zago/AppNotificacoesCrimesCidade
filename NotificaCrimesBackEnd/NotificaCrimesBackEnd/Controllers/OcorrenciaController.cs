using AppNotificacoesCrimesCidade.Application.Dtos;
using AppNotificacoesCrimesCidade.Application.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace NotificaCrimesBackEnd.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class OcorrenciaController : ControllerBase
    {
        private readonly IOcorrenciaService _service;

        public OcorrenciaController(IOcorrenciaService service)
        {
            _service = service;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<OcorrenciaDto>>> GetAllAsync([FromQuery] DateTime dataInicio, [FromQuery] DateTime dataFim)
        {
            var entidades = await _service.GetAllDateFilterAsync(dataInicio, dataFim);
            return entidades.Map<ActionResult>(
                onSuccess: entidades => Ok(entidades),
                onFailure: entidades => BadRequest(entidades)
               );
        }
    }
}
