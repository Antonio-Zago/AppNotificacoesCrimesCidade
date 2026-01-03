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

        Task<Result<bool>> PostFcm(UsuarioFcmForm form);

        Task<Result<bool>> UpdateConfiguracoesAsync(UsuarioConfiguracaoForm form);

        Task<Result<UsuarioConfiguracoesDto>> FindConfiguracoesByEmailAsync(string email);

        Task<Result<bool>> UpdateUsuario(UsuarioForm form);

        Task<Result<bool>> UpdateCodigoValidacaoEmail(string email);

        Task<Result<bool>> ValidarCodigoEmail(UsuarioEmailValidacaoForm form);

    }
}
