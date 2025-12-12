using AppNotificacoesCrimesCidade.Application.Dtos;
using AppNotificacoesCrimesCidade.Application.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace NotificaCrimesBackEnd.Controllers
{
    [Authorize]
    [ApiController]
    [Route("[controller]")]
    public class UsuarioController : ControllerBase
    {
        private readonly IUsuarioService _usuarioService;

        public UsuarioController(IUsuarioService usuarioService)
        {
            _usuarioService = usuarioService;
        }


        [HttpPost]
        [Route("postFcm")]
        public async Task<ActionResult<bool>> PostFcm([FromBody] UsuarioFcmForm model)
        {
            var user = await _usuarioService.PostFcm(model);

            return user.Map<ActionResult>(
                onSuccess: user => Ok(user),
                onFailure: err =>
                {
                    return BadRequest(err);
                }
               );
        }
    }
}
