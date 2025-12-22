using AppNotificacoesCrimesCidade.Application.Dtos;
using AppNotificacoesCrimesCidade.Application.Exceptions;
using AppNotificacoesCrimesCidade.Application.Helpers;
using AppNotificacoesCrimesCidade.Application.Interfaces;
using AppNotificacoesCrimesCidade.Application.Mappers;
using AppNotificacoesCrimesCidade.Domain.Entities;
using AppNotificacoesCrimesCidade.Domain.Interfaces;
using FirebaseAdmin.Messaging;
using Microsoft.AspNetCore.Mvc.Rendering;
using NetTopologySuite.Geometries;
using Npgsql;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace AppNotificacoesCrimesCidade.Application.Services
{
    public class LocalService : ServiceBase<Local, LocalDto, LocalForm>, ILocalService
    {
        private readonly IUnitOfWork _unitOfWork;

        private readonly IMapperBase<Local, LocalDto, LocalForm> _mapper;

        private readonly IHashidsPublicIdService _hashidsPublicIdService;

        private readonly IQuery _query;

        public LocalService(IServiceFactory serviceFactory, IUnitOfWork unitOfWork, IHashidsPublicIdService hashidsPublicIdService, IMapperBase<Local, LocalDto, LocalForm> mapper, IQuery query) : base(serviceFactory, unitOfWork, hashidsPublicIdService, mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _hashidsPublicIdService = hashidsPublicIdService;
            _query = query;
        }

        public async override Task<Result<LocalDto>> AddAsync(LocalForm form)
        {
            try
            {
                await _unitOfWork.BeginTransactionAsync();

                var usuario = await _unitOfWork.UsuarioRepository.FindByEmail(form.Email);
                if (usuario == null)
                {
                    throw new Exception($"Não encontrado usuário com o email: {form.Email}");
                }

                var local = new Local()
                {
                    Nome = form.Nome,
                    UsuarioId = usuario.Id,
                    Coordenadas = new Point(form.Longitude, form.Latitude) { SRID = 4326 }
                };

                var localSalvo = await _unitOfWork.LocalRepository.AddAsync(local);

                await _unitOfWork.CommitAsync();

                await _unitOfWork.CommitTransactionAsync();

                var dto = new LocalDto()
                {
                    Id = _hashidsPublicIdService.ToPublic(localSalvo.Id),
                    Nome = localSalvo.Nome,
                    Latitude = localSalvo.Coordenadas.Y,
                    Longitude = localSalvo.Coordenadas.X,
                };

                return Result<LocalDto>.Success(dto);
            }
            catch (Exception ex)
            {
                await _unitOfWork.RoolbackTransactionAsync();
                return Result<LocalDto>.Failure(new ErrorDefault(ex.Message));
            }
        }

        public async Task<Result<IReadOnlyList<LocalDto>>> GetAllByEmail(string email)
        {
            List<LocalDto> dtos = new List<LocalDto>();

            try
            {
                var usuario = await _unitOfWork.UsuarioRepository.FindByEmail(email);

                if (usuario == null)
                {
                    throw new Exception($"Usuário não encontrado com email: {email}");
                }

                var locais = await _unitOfWork.LocalRepository.GetAllByUserId(usuario.Id);

                foreach (var local in locais)
                {

                    var idPublic = _hashidsPublicIdService.ToPublic(local.Id);

                    LocalDto localDto = new LocalDto()
                    {
                        Id = idPublic,
                        Latitude = local.Coordenadas.Y,
                        Longitude = local.Coordenadas.X,
                        Nome = local.Nome
                    };

                    dtos.Add(localDto);
                }

                return Result<IReadOnlyList<LocalDto>>.Success(dtos.AsReadOnly());
            }
            catch (Exception ex)
            {
                return Result<IReadOnlyList<LocalDto>>.Failure(new ErrorDefault(ex.Message));
            }

        }

        public async override Task<Result<LocalDto>> UpdateAsync(LocalForm form, string idPublic)
        {
            try
            {
                await _unitOfWork.BeginTransactionAsync();

                var usuario = await _unitOfWork.UsuarioRepository.FindByEmail(form.Email);
                if (usuario == null)
                {
                    throw new Exception($"Não encontrado usuário com o email: {form.Email}");
                }

                var idLocal = _hashidsPublicIdService.ToInternal(idPublic);

                var local = await _unitOfWork.LocalRepository.GetByIdAsync(idLocal.Value);

                if (local == null)
                {
                    throw new Exception($"Não encontrado local");
                }

                local.Nome = form.Nome;
                local.Coordenadas.Y = form.Latitude;
                local.Coordenadas.X = form.Longitude;

                var localSalvo = await _unitOfWork.LocalRepository.UpdateAsync(local);

                await _unitOfWork.CommitAsync();

                await _unitOfWork.CommitTransactionAsync();

                var dto = new LocalDto()
                {
                    Id = _hashidsPublicIdService.ToPublic(localSalvo.Id),
                    Nome = localSalvo.Nome,
                    Latitude = localSalvo.Coordenadas.Y,
                    Longitude = localSalvo.Coordenadas.X,
                };

                return Result<LocalDto>.Success(dto);
            }
            catch (Exception ex)
            {
                await _unitOfWork.RoolbackTransactionAsync();
                return Result<LocalDto>.Failure(new ErrorDefault(ex.Message));
            }
        }

        public async override Task<Result> DeleteAsync(string idPublic)
        {
            try
            {
                await _unitOfWork.BeginTransactionAsync();

                var idLocal = _hashidsPublicIdService.ToInternal(idPublic);

                await _unitOfWork.LocalRepository.DeleteAsync(idLocal.Value);


                await _unitOfWork.CommitAsync();

                await _unitOfWork.CommitTransactionAsync();


                return Result.Success();
            }
            catch (Exception ex)
            {
                await _unitOfWork.RoolbackTransactionAsync();
                return Result<LocalDto>.Failure(new ErrorDefault(ex.Message));
            }
        }

        public async Task<Result<bool>> EnviarNotificacoes(double latitude, double longitude, int usuarioId)
        {
            try
            {
                var locaisNotificar = _query.ExecuteReader(@"SELECT B.FCMTOKEN,
                                                             ST_Distance(
                                                                A.COORDENADAS,
                                                                ST_SetSRID(
                                                                    ST_MakePoint(@longitude, @latitude),
                                                                    4326
                                                                )::geography
                                                            ) AS DISTANCIA,
                                                            A.NOME
                                                        FROM LOCAIS A
                                                        INNER JOIN USUARIOS B ON A.USUARIO_ID = B.ID
                                                        WHERE ST_DWithin(
                                                            A.COORDENADAS,
                                                            ST_SetSRID(ST_MakePoint(@longitude, @latitude), 4326)::geography,
                                                            5000 
                                                        )
                                                        AND FCMTOKEN IS NOT NULL
                                                        AND B.ID <> @usuario", [new NpgsqlParameter("@longitude", longitude),
                                                                                new NpgsqlParameter("@latitude", latitude),
                                                                                new NpgsqlParameter("@usuario", usuarioId)]);


                foreach (var localNotificar in locaisNotificar)
                {
                    string distanciaFormatada = ((double)localNotificar["distancia"]).ToString("F2", CultureInfo.InvariantCulture);

                    var message = new Message()
                    {
                        Notification = new Notification
                        {
                            Title = $"Ocorrência registrada perto de local salvo",
                            Body = $"Ocorrência registrada a {distanciaFormatada}m do local {(string)localNotificar["nome"]}"
                        },
                        Token = (string)localNotificar["fcmtoken"]
                    };

                    // Send a message to the device corresponding to the provided
                    // registration token.
                    string response = await FirebaseMessaging.DefaultInstance.SendAsync(message);
                }

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
