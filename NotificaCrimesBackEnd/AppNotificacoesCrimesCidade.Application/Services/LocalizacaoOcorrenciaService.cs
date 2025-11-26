using AppNotificacoesCrimesCidade.Application.Dtos;
using AppNotificacoesCrimesCidade.Application.Exceptions;
using AppNotificacoesCrimesCidade.Application.Helpers;
using AppNotificacoesCrimesCidade.Application.Interfaces;
using AppNotificacoesCrimesCidade.Application.Mappers;
using AppNotificacoesCrimesCidade.Domain.Entities;
using AppNotificacoesCrimesCidade.Domain.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Services
{
    public class LocalizacaoOcorrenciaService : ServiceBase<LocalizacaoOcorrencia, LocalizacaoOcorrenciaDto, LocalizacaoOcorrenciaForm>, ILocalizacaoOcorrenciaService
    {
        private readonly IUnitOfWork _unitOfWork;

        private readonly IHashidsPublicIdService _hashidsPublicIdService;

        public LocalizacaoOcorrenciaService(IServiceFactory serviceFactory, IUnitOfWork unitOfWork, IHashidsPublicIdService hashidsPublicIdService, IMapperBase<LocalizacaoOcorrencia, LocalizacaoOcorrenciaDto, LocalizacaoOcorrenciaForm> mapper) : base(serviceFactory, unitOfWork, hashidsPublicIdService, mapper)
        {
            _unitOfWork = unitOfWork;
            _hashidsPublicIdService = hashidsPublicIdService;
        }

        public async override Task<Result<LocalizacaoOcorrenciaDto>> GetByIdAsync(string id)
        {
            try
            {
                var idEntidade = _hashidsPublicIdService.ToInternal(id);

                if (idEntidade == null)
                {
                    throw new Exception($"Não foi possível converter o id: {id}");
                }

                var entidade = await _unitOfWork.LocalizacaoOcorrenciaRepository.GetByIdAsync(idEntidade.Value);

                if (entidade == null)
                {
                    throw new Exception($"Localização não encontrada com o id: {idEntidade}");
                }

                var dto = new LocalizacaoOcorrenciaDto
                {
                    Id = id,
                    Bairro = entidade.Bairro,
                    cep = entidade.Cep,
                    Cidade = entidade.Cidade,
                    Numero = entidade.Numero,
                    Rua = entidade.Rua,
                    Latitude = entidade.Coordenadas.Y,
                    Longitude = entidade.Coordenadas.X
                };

                return Result<LocalizacaoOcorrenciaDto>.Success(dto);
            }
            catch (Exception ex)
            {
                await _unitOfWork.RoolbackTransactionAsync();
                return Result<LocalizacaoOcorrenciaDto>.Failure(new ErrorDefault(ex.Message));
            }
        }
    }
}
