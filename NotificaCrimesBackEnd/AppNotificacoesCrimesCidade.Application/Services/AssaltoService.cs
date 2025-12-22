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
    public class AssaltoService : ServiceBase<Assalto, AssaltoDto, AssaltoForm>, IAssaltoService
    {
        private readonly IUnitOfWork _unitOfWork;

        private readonly IMapperBase<Assalto, AssaltoDto, AssaltoForm> _mapper;

        private readonly IHashidsPublicIdService _hashidsPublicIdService;

        private readonly ILocalService _localService;

        public AssaltoService(IServiceFactory serviceFactory, IUnitOfWork unitOfWork, IHashidsPublicIdService hashidsPublicIdService, IMapperBase<Assalto, AssaltoDto, AssaltoForm> mapper, ILocalService localService) : base(serviceFactory, unitOfWork, hashidsPublicIdService, mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _hashidsPublicIdService = hashidsPublicIdService;
            _localService = localService;
        }

        public async override Task<Result<AssaltoDto>> AddAsync(AssaltoForm form)
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
                    UsuarioId = usuario.Id
                };

                var listaTipoBens = new List<AssaltoTipoBem>();

                foreach (var idTipoBem in form.TipoBensId)
                {
                    var tipoBemIdInternal = _hashidsPublicIdService.ToInternal(idTipoBem);

                    var tipoBem = await _unitOfWork.TipoBemRepository.GetByIdAsync(tipoBemIdInternal.Value);
                    if (tipoBem == null)
                    {
                        throw new Exception($"Tipo bem não existente com id: {idTipoBem}");
                    }

                    var assaltoTipoBem = new AssaltoTipoBem()
                    {
                        TipoBem = tipoBem,
                    };

                    listaTipoBens.Add(assaltoTipoBem);
                }

                int? tipoArmaId = null;

                if (!string.IsNullOrEmpty(form.TipoArmaId))
                {
                    tipoArmaId = _hashidsPublicIdService.ToInternal(form.TipoArmaId);
                }

                var assalto = new Assalto()
                {
                    Ocorrencia = ocorrencia,
                    PossuiArma = form.PossuiArma,
                    QtdAgressores = form.QtdAgressores,
                    Tentativa = form.Tentativa,
                    TipoArmaId = tipoArmaId,
                    AssaltoTipoBens = listaTipoBens
                };

                var assaltoSalvo = await _unitOfWork.AssaltoRepository.AddAsync(assalto);

                var resultadoEnvioNotificacoes = await _localService.EnviarNotificacoes(form.Ocorrencia.Localizacao.Latitude, form.Ocorrencia.Localizacao.Longitude, usuario.Id);

                resultadoEnvioNotificacoes.Map<bool>(
                    onSuccess: resultadoEnvioNotificacoes => true,
                    onFailure: resultadoEnvioNotificacoes => throw new Exception("Erro no envio das notificações")
                );

                await _unitOfWork.CommitAsync();

                await _unitOfWork.CommitTransactionAsync();

                return Result<AssaltoDto>.Success(_mapper.ConvertToDto(assaltoSalvo));
            }
            catch (Exception ex)
            {
                await _unitOfWork.RoolbackTransactionAsync();
                return Result<AssaltoDto>.Failure(new ErrorDefault(ex.Message));
            }
            
        }
    }
}
