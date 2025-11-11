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
    public class AgressaoService : ServiceBase<Agressao, AgressaoDto, AgressaoForm>, IAgressaoService
    {
        private readonly IUnitOfWork _unitOfWork;

        private readonly IMapperBase<Agressao, AgressaoDto, AgressaoForm> _mapper;

        public AgressaoService(IServiceFactory serviceFactory, IUnitOfWork unitOfWork, IHashidsPublicIdService hashidsPublicIdService, IMapperBase<Agressao, AgressaoDto, AgressaoForm> mapper) : base(serviceFactory, unitOfWork, hashidsPublicIdService, mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
        }

        public async override Task<Result<AgressaoDto>> AddAsync(AgressaoForm form)
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

                var ocorrencia = new Ocorrencia()
                {
                    Descricao = form.Ocorrencia.Descricao,
                    //Aqui eu recebo o valor local (brasil) e converto para UTC para armazenar no banco de dados
                    DataHora = DateTime.SpecifyKind(form.Ocorrencia.DataHora, DateTimeKind.Local).ToUniversalTime(),
                    Localizacao = localizacaoOcorrencia
                };


                var agressao = new Agressao()
                {
                    Ocorrencia = ocorrencia,
                    QtdAgressores = form.QtdAgressores,
                    Fisica = form.Fisica,
                    Verbal = form.Verbal,
                };

                var agressaoSalvo = await _unitOfWork.AgressaoRepository.AddAsync(agressao);

                await _unitOfWork.CommitAsync();

                await _unitOfWork.CommitTransactionAsync();

                return Result<AgressaoDto>.Success(_mapper.ConvertToDto(agressaoSalvo));
            }
            catch (Exception ex)
            {
                await _unitOfWork.RoolbackTransactionAsync();
                return Result<AgressaoDto>.Failure(new ErrorDefault(ex.Message));
            }

        }
    }
}
