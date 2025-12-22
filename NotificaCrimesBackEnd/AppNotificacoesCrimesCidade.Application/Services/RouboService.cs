using AppNotificacoesCrimesCidade.Application.Dtos;
using AppNotificacoesCrimesCidade.Application.Exceptions;
using AppNotificacoesCrimesCidade.Application.Helpers;
using AppNotificacoesCrimesCidade.Application.Interfaces;
using AppNotificacoesCrimesCidade.Application.Mappers;
using AppNotificacoesCrimesCidade.Domain.Entities;
using AppNotificacoesCrimesCidade.Domain.Interfaces;
using NetTopologySuite.Geometries;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Services
{
    public class RouboService : ServiceBase<Roubo, RouboDto, RouboForm>, IRouboService
    {
        private readonly IUnitOfWork _unitOfWork;

        private readonly IMapperBase<Roubo, RouboDto, RouboForm> _mapper;

        private readonly IHashidsPublicIdService _hashidsPublicIdService;

        private readonly ILocalService _localService;

        public RouboService(IServiceFactory serviceFactory, IUnitOfWork unitOfWork, IHashidsPublicIdService hashidsPublicIdService, IMapperBase<Roubo, RouboDto, RouboForm> mapper, ILocalService localService) : base(serviceFactory, unitOfWork, hashidsPublicIdService, mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _hashidsPublicIdService = hashidsPublicIdService;
            _localService = localService;
        }

        public async override Task<Result<RouboDto>> AddAsync(RouboForm form)
        {
            try
            {
                await _unitOfWork.BeginTransactionAsync();


                var localizacaoOcorrencia = new LocalizacaoOcorrencia()
                {
                    Bairro = form.Ocorrencia.Localizacao.Bairro,
                    Cep = form.Ocorrencia.Localizacao.Cep,
                    Cidade = form.Ocorrencia.Localizacao.Cidade,
                    Numero = form.Ocorrencia.Localizacao.Numero,
                    Rua = form.Ocorrencia.Localizacao.Rua,
                    Coordenadas = new Point(form.Ocorrencia.Localizacao.Longitude, form.Ocorrencia.Localizacao.Latitude) { SRID = 4326 }
                };

                var usuario = await _unitOfWork.UsuarioRepository.FindByEmail(form.Ocorrencia.Email);
                if (usuario == null)
                {
                    throw new Exception($"Não encontrado usuário com o email: {form.Ocorrencia.Email}");
                }

                var ocorrencia = new Ocorrencia()
                {
                    Descricao = form.Ocorrencia.Descricao,
                    //Aqui eu recebo o valor local (brasil) e converto para UTC para armazenar no banco de dados
                    DataHora = DateTime.SpecifyKind(form.Ocorrencia.DataHora, DateTimeKind.Local).ToUniversalTime(),
                    Localizacao = localizacaoOcorrencia,
                    UsuarioId = usuario.Id,
                };


                var listaTipoBens = new List<RouboTipoBem>();

                foreach (var idTipoBem in form.TipoBensId)
                {
                    var tipoBemIdInternal = _hashidsPublicIdService.ToInternal(idTipoBem);

                    var tipoBem = await _unitOfWork.TipoBemRepository.GetByIdAsync(tipoBemIdInternal.Value);
                    if (tipoBem == null)
                    {
                        throw new Exception($"Tipo bem não existente com id: {idTipoBem}");
                    }

                    var assaltoTipoBem = new RouboTipoBem()
                    {
                        TipoBem = tipoBem,
                    };

                    listaTipoBens.Add(assaltoTipoBem);
                }

                var roubo = new Roubo()
                {
                    Ocorrencia = ocorrencia,
                    Tentativa = form.Tentativa,
                    RouboTipoBens = listaTipoBens
                };

                var rouboSalvo = await _unitOfWork.RouboRepository.AddAsync(roubo);

                var resultadoEnvioNotificacoes = await _localService.EnviarNotificacoes(form.Ocorrencia.Localizacao.Latitude, form.Ocorrencia.Localizacao.Longitude, usuario.Id);

                resultadoEnvioNotificacoes.Map<bool>(
                    onSuccess: resultadoEnvioNotificacoes => true,
                    onFailure: resultadoEnvioNotificacoes => throw new Exception("Erro no envio das notificações")
                );

                await _unitOfWork.CommitAsync();

                await _unitOfWork.CommitTransactionAsync();

                return Result<RouboDto>.Success(_mapper.ConvertToDto(rouboSalvo));
            }
            catch (Exception ex)
            {
                await _unitOfWork.RoolbackTransactionAsync();
                return Result<RouboDto>.Failure(new ErrorDefault(ex.Message));
            }

        }
    }
}
