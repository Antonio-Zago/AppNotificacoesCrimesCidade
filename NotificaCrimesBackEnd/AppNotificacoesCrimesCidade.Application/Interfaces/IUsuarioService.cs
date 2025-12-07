using AppNotificacoesCrimesCidade.Application.Dtos;
using AppNotificacoesCrimesCidade.Application.Helpers;
using AppNotificacoesCrimesCidade.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Interfaces
{
    public interface IUsuarioService : IServiceBase<Usuario, UsuarioDto, UsuarioForm>
    {
        Task<Result<UsuarioLoginDto>> Login(UsuarioLoginForm model);

        Task<Result<TokenDto>> RefreshToken(TokenForm tokenForm);

    }
}
