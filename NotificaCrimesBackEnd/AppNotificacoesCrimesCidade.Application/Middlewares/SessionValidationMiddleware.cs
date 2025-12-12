using AppNotificacoesCrimesCidade.Application.Interfaces;
using AppNotificacoesCrimesCidade.Application.Services;
using AppNotificacoesCrimesCidade.Domain.Interfaces;
using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Middlewares
{
    public class SessionValidationMiddleware
    {
        private readonly RequestDelegate _next;

        public SessionValidationMiddleware(RequestDelegate next)
        {
            _next = next;
        }

        public async Task Invoke(HttpContext context, IUnitOfWork unitOfWork, IHashidsPublicIdService hashidsPublicIdService)
        {
            if (context.User.Identity?.IsAuthenticated == true)
            {
                var userEmail = context.User.FindFirstValue(ClaimTypes.Email)
                          ?? context.User.FindFirstValue(JwtRegisteredClaimNames.Sub);

                var sessionId = context.User.FindFirst("sessionId")?.Value;

                if (userEmail != null && sessionId != null)
                {
                    var guid = Guid.Parse(sessionId);

                    var usuario = await unitOfWork.UsuarioRepository.FindByEmail(userEmail);

                    if (usuario == null || usuario.SessionId != guid)
                    {
                        context.Response.StatusCode = 400;
                        return;
                    }
                }
            }

            await _next(context);
        }
    }
}
