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

        [HttpPut]
        [Route("updateConfiguracoes")]
        public async Task<ActionResult<bool>> UpdateConfiguracoes([FromBody] UsuarioConfiguracaoForm model)
        {
            var user = await _usuarioService.UpdateConfiguracoesAsync(model);

            return user.Map<ActionResult>(
                onSuccess: user => Ok(user),
                onFailure: err =>
                {
                    return BadRequest(err);
                }
               );
        }

        [HttpGet("getConfiguracoes/{email}")]
        public async Task<ActionResult<UsuarioConfiguracoesDto>> UpdateConfiguracoes(string email)
        {
            var user = await _usuarioService.FindConfiguracoesByEmailAsync(email);

            return user.Map<ActionResult>(
                onSuccess: user => Ok(user),
                onFailure: err =>
                {
                    return BadRequest(err);
                }
               );
        }

        [HttpPut]
        public async Task<ActionResult<bool>> Update([FromBody] UsuarioForm model)
        {
            var user = await _usuarioService.UpdateUsuario(model);

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
