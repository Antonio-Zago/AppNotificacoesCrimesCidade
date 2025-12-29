using AppNotificacoesCrimesCidade.Application.Dtos;
using AppNotificacoesCrimesCidade.Application.Exceptions;
using AppNotificacoesCrimesCidade.Application.Helpers;
using AppNotificacoesCrimesCidade.Application.Interfaces;
using AppNotificacoesCrimesCidade.Application.Mappers;
using AppNotificacoesCrimesCidade.Domain.Entities;
using AppNotificacoesCrimesCidade.Domain.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Services
{
    public class UsuarioService : ServiceBase<Usuario, UsuarioDto, UsuarioForm>, IUsuarioService
    {
        private readonly IUnitOfWork _unitOfWork;

        private readonly IMapperBase<Usuario, UsuarioDto, UsuarioForm> _mapper;

        private readonly IHashidsPublicIdService _hashidsPublicIdService;

        private readonly ITokenService _tokenService;

        private readonly IConfiguration _config;
        public UsuarioService(IServiceFactory serviceFactory, IUnitOfWork unitOfWork, IHashidsPublicIdService hashidsPublicIdService, IMapperBase<Usuario, UsuarioDto, UsuarioForm> mapper, ITokenService tokenService, IConfiguration config) : base(serviceFactory, unitOfWork, hashidsPublicIdService, mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _hashidsPublicIdService = hashidsPublicIdService;
            _tokenService = tokenService;
            _config = config;
        }

        private async Task<Usuario> FindByEmail(string email)
        {

            var usuario = await _unitOfWork.UsuarioRepository.FindByEmail(email);
            if (usuario != null)
            {
                return usuario;
            }
            throw new Exception($"Não encontrado usuário com o email: {email}");

        }

        private async Task<Usuario> FindByFcmToken(string fcmToken)
        {
            var usuario = await _unitOfWork.UsuarioRepository.FindByFcmToken(fcmToken);

            return usuario;
        }

        private async Task<Usuario> FindByUserName(string userName)
        {

            var usuario = await _unitOfWork.UsuarioRepository.FindByUserName(userName);

            if (usuario != null)
            {
                return usuario;
            }
            throw new Exception($"Não encontrado usuário com o userName: {userName}");

        }

        public async Task<Result<bool>> PostFcm(UsuarioFcmForm form)
        {
            try
            {
                await _unitOfWork.BeginTransactionAsync();

                var usuarioComFcmToken = await FindByFcmToken(form.TokenFcm);

                if (usuarioComFcmToken != null)
                {
                    usuarioComFcmToken.FcmToken = null;
                    await _unitOfWork.UsuarioRepository.UpdateAsync(usuarioComFcmToken);
                }
            
                var user = await FindByEmail(form.Email);

                if (user is null)
                {
                    return Result<bool>.Failure(
                        new ErrorDefault("Email inválido", StatusCodes.Status401Unauthorized)
                    );
                }

                user.FcmToken = form.TokenFcm;

                var entidadeAtualizada = await _unitOfWork.UsuarioRepository.UpdateAsync(user);    

                await _unitOfWork.CommitAsync();

                await _unitOfWork.CommitTransactionAsync();

                return Result<bool>.Success(true);

            }
            catch (Exception ex)
            {
                await _unitOfWork.RoolbackTransactionAsync();
                return Result<bool>.Failure(new ErrorDefault(ex.Message));
            }
        }

        public async Task<Result<UsuarioLoginDto>> Login(UsuarioLoginForm model)
        {
            try
            {
                await _unitOfWork.BeginTransactionAsync();

                var user = await FindByEmail(model.Email);

                if (user is null || !CheckPassword(model.Senha, user.Senha))
                {
                    return Result<UsuarioLoginDto>.Failure(
                        new ErrorDefault("Usuário ou senha inválidos", StatusCodes.Status401Unauthorized)
                    );
                }

                var sessionId = Guid.NewGuid();

                var authClaims = new List<Claim>
                {
                    new Claim(ClaimTypes.Name, user.Nome),
                    new Claim(ClaimTypes.Email, user.Email),
                    new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
                    new Claim("sessionId", sessionId.ToString()),
                };


                var token = _tokenService.GenerateAccessToken(authClaims,
                                                             _config);

                var refreshToken = _tokenService.GenerateRefreshToken();

                _ = int.TryParse(_config["JWT:RefreshTokenValidityInMinutes"],
                                   out int refreshTokenValidityInMinutes);

                user.RefreshToken = refreshToken;
                user.RefreshTokenExpiryTime = DateTime.SpecifyKind(DateTime.Now.AddMinutes(refreshTokenValidityInMinutes), DateTimeKind.Local).ToUniversalTime();

                user.SessionId = sessionId;

                var entidadeAtualizada = await _unitOfWork.UsuarioRepository.UpdateAsync(user);

                await _unitOfWork.CommitAsync();

                await _unitOfWork.CommitTransactionAsync();

                return Result<UsuarioLoginDto>.Success(new UsuarioLoginDto
                {
                    Token = new JwtSecurityTokenHandler().WriteToken(token),
                    RefreshToken = refreshToken,
                    Expiration = token.ValidTo,
                    Usuario = user.Nome,
                    Email = user.Email,
                    Foto = user.Foto
                });
                
                throw new Exception($"Não encontrado usuário");

            }
            catch (Exception ex)
            {
                await _unitOfWork.RoolbackTransactionAsync();   
                return Result<UsuarioLoginDto>.Failure(new ErrorDefault(ex.Message));
            }

        }

        public async Task<Result<TokenDto>> RefreshToken(TokenForm tokenForm)
        {
            try
            {
                await _unitOfWork.BeginTransactionAsync();

                string? accessToken = tokenForm.AccessToken
                                  ?? throw new ArgumentNullException(nameof(tokenForm));

                string? refreshToken = tokenForm.RefreshToken
                                       ?? throw new ArgumentException(nameof(tokenForm));

                var sessionId = Guid.NewGuid();

                var principal = _tokenService.GetPrincipalFromExpiredToken(accessToken!, _config);

                if (principal == null)
                {
                    throw new Exception("Invalid access token/refresh token");
                }
                string username = principal.Identity.Name;

                var user = await FindByUserName(username!);

                if (user == null || user.RefreshToken != refreshToken
                                 || user.RefreshTokenExpiryTime <= DateTime.Now)
                {
                    throw new Exception("Invalid access token/refresh token");
                }

                var newAccessToken = _tokenService.GenerateAccessToken(
                                                   principal.Claims.ToList(), _config);

                var newRefreshToken = _tokenService.GenerateRefreshToken();

                user.RefreshToken = newRefreshToken;

                user.SessionId = sessionId;

                var entidadeAtualizada = await _unitOfWork.UsuarioRepository.UpdateAsync(user);

                await _unitOfWork.CommitAsync();

                await _unitOfWork.CommitTransactionAsync();

                return Result<TokenDto>.Success(new TokenDto()
                {
                    Token = new JwtSecurityTokenHandler().WriteToken(newAccessToken),
                    RefreshToken = newRefreshToken
                });
            }
            catch (Exception ex)
            {
                await _unitOfWork.RoolbackTransactionAsync();
                return Result<TokenDto>.Failure(new ErrorDefault(ex.Message));
            }

        }

        private bool CheckPassword(string senhaForm, string senha)
        {
            return senhaForm.GerarHash() == senha;
        }

        public async override Task<Result<UsuarioDto>> AddAsync(UsuarioForm form)
        {
            try
            {
                await _unitOfWork.BeginTransactionAsync();

                var usuario = await _unitOfWork.UsuarioRepository.FindByEmail(form.Email);

                if (usuario != null)
                {
                    throw new Exception("Já existe usuário para esse email");
                }

                byte[] fotoBytes = null;

                if (!form.Foto.IsNullOrEmpty())
                {
                    fotoBytes = Convert.FromBase64String(form.Foto);
                }

                var usuarioNovo = new Usuario()
                {
                    Email = form.Email,
                    Nome = form.Nome,
                    Senha = form.Senha.GerarHash(),
                    Foto = fotoBytes,
                };

                var entidadeSalva = await _unitOfWork.UsuarioRepository.AddAsync(usuarioNovo);

                var usuarioConfiguracoes = new UsuarioConfiguracoes()
                {
                    NotificaLocal = true,
                    NotificaLocalizacao = true,
                    DistanciaLocal = 3000,
                    DistanciaLocalizacao = 3000,
                    Usuario = entidadeSalva
                };

                var entidadeConfiguracoesSalva = await _unitOfWork.UsuarioConfiguracoesRepository.AddAsync(usuarioConfiguracoes);

                var dto = _mapper.ConvertToDto(entidadeSalva);

                await _unitOfWork.CommitAsync();

                await _unitOfWork.CommitTransactionAsync();

                return Result<UsuarioDto>.Success(dto);
            }
            catch (Exception ex)
            {
                await _unitOfWork.RoolbackTransactionAsync();
                return Result<UsuarioDto>.Failure(new ErrorDefault(ex.Message));
            }
        }

        public async Task<Result<bool>> UpdateConfiguracoesAsync(UsuarioConfiguracaoForm form)
        {
            try
            {
                await _unitOfWork.BeginTransactionAsync();

                var usuario = await _unitOfWork.UsuarioConfiguracoesRepository.FindByEmail(form.Email);

                if (usuario == null)
                {
                    throw new Exception("Configurações não encontradas para o usuário");
                }

                usuario.NotificaLocal = form.NotificaLocal;
                usuario.NotificaLocalizacao = form.NotificaLocalizacao;
                usuario.DistanciaLocal = form.DistanciaLocal;
                usuario.DistanciaLocalizacao = form.DistanciaLocalizacao;

                var entidadeConfiguracoesSalva = await _unitOfWork.UsuarioConfiguracoesRepository.UpdateAsync(usuario);

                await _unitOfWork.CommitAsync();

                await _unitOfWork.CommitTransactionAsync();

                return Result<bool>.Success(true);
            }
            catch (Exception ex)
            {
                await _unitOfWork.RoolbackTransactionAsync();
                return Result<bool>.Failure(new ErrorDefault(ex.Message));
            }
        }

        public async Task<Result<UsuarioConfiguracoesDto>> FindConfiguracoesByEmailAsync(string email)
        {
            try
            {
                var usuario = await _unitOfWork.UsuarioConfiguracoesRepository.FindByEmail(email);

                if (usuario == null)
                {
                    throw new Exception("Configurações não encontradas para o usuário");
                }

                var usuarioConfiguracoes = new UsuarioConfiguracoesDto()
                {
                    NotificaLocal = usuario.NotificaLocal,
                    NotificaLocalizacao = usuario.NotificaLocalizacao,
                    DistanciaLocal = usuario.DistanciaLocal,
                    DistanciaLocalizacao = usuario.DistanciaLocalizacao
                };       

                return Result<UsuarioConfiguracoesDto>.Success(usuarioConfiguracoes);
            }
            catch (Exception ex)
            {
                return Result<UsuarioConfiguracoesDto>.Failure(new ErrorDefault(ex.Message));
            }
        }

        public async Task<Result<bool>> UpdateUsuario(UsuarioForm form)
        {
            try
            {
                await _unitOfWork.BeginTransactionAsync();

                var usuario = await _unitOfWork.UsuarioRepository.FindByEmail(form.Email);

                if (usuario == null)
                {
                    throw new Exception("Usuário não encontrado");
                }


                byte[] fotoBytes = null;

                if (!form.Foto.IsNullOrEmpty())
                {
                    fotoBytes = Convert.FromBase64String(form.Foto);
                }

                usuario.Nome = form.Nome;
                usuario.Foto = fotoBytes;

                var entidadeConfiguracoesSalva = await _unitOfWork.UsuarioRepository.UpdateAsync(usuario);

                await _unitOfWork.CommitAsync();

                await _unitOfWork.CommitTransactionAsync();

                return Result<bool>.Success(true);
            }
            catch (Exception ex)
            {
                await _unitOfWork.RoolbackTransactionAsync();
                return Result<bool>.Failure(new ErrorDefault(ex.Message));
            }
        }
    }
}
