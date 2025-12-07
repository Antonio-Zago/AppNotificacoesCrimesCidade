using AppNotificacoesCrimesCidade.Application.Dtos;
using AppNotificacoesCrimesCidade.Application.Helpers;
using AppNotificacoesCrimesCidade.Application.Interfaces;
using Microsoft.AspNetCore.Mvc;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;

namespace NotificaCrimesBackEnd.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class AuthController : ControllerBase
    {
        private readonly IUsuarioService _usuarioService;

        public AuthController(IUsuarioService usuarioService)
        {
            _usuarioService = usuarioService;
        }


        [HttpPost]
        [Route("login")]
        public async Task<ActionResult<UsuarioLoginDto>> Login([FromBody] UsuarioLoginForm model)
        {
            var user = await _usuarioService.Login(model);

            return user.Map<ActionResult>(
                onSuccess: user => Ok(user),
                onFailure: err =>
                {
                    if (err.StatusCode == StatusCodes.Status401Unauthorized)
                        return Unauthorized(err);

                    return BadRequest(err);
                }
               );
        }

        [HttpPost]
        [Route("register")]
        public async Task<ActionResult<UsuarioDto>> Register([FromBody] UsuarioForm model)
        {
            var result = await _usuarioService.AddAsync(model);

            return result.Map<ActionResult>(
                onSuccess: result => Ok(result),
                onFailure: result => BadRequest(result)
               );

        }

        [HttpPost]
        [Route("refresh-token")]
        public async Task<ActionResult<TokenDto>> RefreshToken([FromBody] TokenForm tokenForm)
        {

            var result = await _usuarioService.RefreshToken(tokenForm);

            return result.Map<ActionResult>(
                onSuccess: result => Ok(result),
                onFailure: result => BadRequest(result)
               );
        }
    }
}
