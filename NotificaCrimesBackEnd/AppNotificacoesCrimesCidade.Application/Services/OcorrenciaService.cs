using AppNotificacoesCrimesCidade.Application.Dtos;
using AppNotificacoesCrimesCidade.Application.Exceptions;
using AppNotificacoesCrimesCidade.Application.Helpers;
using AppNotificacoesCrimesCidade.Application.Interfaces;
using AppNotificacoesCrimesCidade.Application.Mappers;
using AppNotificacoesCrimesCidade.Domain.Entities;
using AppNotificacoesCrimesCidade.Domain.Interfaces;
using FirebaseAdmin.Messaging;
using Npgsql;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Services
{
    public class OcorrenciaService : ServiceBase<Ocorrencia, OcorrenciaDto, OcorrenciaForm>, IOcorrenciaService
    {
        private readonly IUnitOfWork _unitOfWork;

        private readonly IHashidsPublicIdService _hashidsPublicIdService;

        private readonly IAssaltoService _assaltoService;

        private readonly IRouboService _rouboService;

        private readonly IAgressaoService _agressaoService;

        private readonly ILocalizacaoOcorrenciaService _localizacaoService;

        private readonly IQuery _query;

        public OcorrenciaService(IServiceFactory serviceFactory, IUnitOfWork unitOfWork, IHashidsPublicIdService hashidsPublicIdService, IMapperBase<Ocorrencia, OcorrenciaDto, OcorrenciaForm> mapper, IAssaltoService assaltoService, IRouboService rouboService, IAgressaoService agressaoService, IQuery query, ILocalizacaoOcorrenciaService localizacaoService) : base(serviceFactory, unitOfWork, hashidsPublicIdService, mapper)
        {
            _unitOfWork = unitOfWork;
            _hashidsPublicIdService = hashidsPublicIdService;
            _assaltoService = assaltoService;
            _rouboService = rouboService;
            _agressaoService = agressaoService;
            _query = query;
            _localizacaoService = localizacaoService;
        }

        public async Task<Result<IReadOnlyList<OcorrenciaDto>>> GetAllDateFilterAsync(DateTime dataInicio, DateTime dataFim)
        {
            List<OcorrenciaDto> dtos = new List<OcorrenciaDto>();

            try
            {

                var ocorrencias = _query.ExecuteReader(@"SELECT 
                                        a.id AS Ocorrencia,
                                        b.id AS Assalto,
                                        c.id AS Roubo,
                                        d.id AS Agressao,
                                        a.descricao,
                                        a.dataHora,
                                        a.id_localizacao,
                                        CASE 
                                            WHEN b.id IS NOT NULL THEN 'ASSALTO'
                                            WHEN c.id IS NOT NULL THEN 'ROUBO'
                                            WHEN d.id IS NOT NULL THEN 'AGRESSAO'
                                            ELSE 'DESCONHECIDO'
                                        END AS Tipo,
                                        a.id_usuario
                                    FROM ocorrencias a
                                    LEFT JOIN assaltos b ON a.id = b.id_ocorrencia
                                    LEFT JOIN roubos c ON a.id = c.id_ocorrencia
                                    LEFT JOIN agressoes d ON a.id = d.id_ocorrencia
                                    WHERE a.dataHora BETWEEN @inicio AND @fim", [new NpgsqlParameter("@inicio", dataInicio), new NpgsqlParameter("@fim", dataFim)]);


                foreach (var ocorrencia in ocorrencias)
                {

                    AssaltoDto? assaltoDto = new AssaltoDto();
                    RouboDto? rouboDto = new RouboDto();
                    AgressaoDto? agressaoDto = new AgressaoDto();

                    if ((string)ocorrencia["tipo"] == "ASSALTO")
                    {
                        var id = (int)ocorrencia["assalto"];

                        var idPublic = _hashidsPublicIdService.ToPublic(id);

                        var dtoAssalto = await _assaltoService.GetByIdAsync(idPublic);

                        var resultDto = dtoAssalto.Map(
                            onSuccess: dto => dto,
                            onFailure: dto => throw new Exception("Não foi possível obter o dto")
                           );

                        assaltoDto = resultDto;
                        rouboDto = null;
                        agressaoDto = null;
                    }
                    else if ((string)ocorrencia["tipo"] == "ROUBO")
                    {
                        var id = (int)ocorrencia["roubo"];

                        var idPublic = _hashidsPublicIdService.ToPublic(id);

                        var dtoRoubo = await _rouboService.GetByIdAsync(idPublic);

                        var resultDto = dtoRoubo.Map(
                            onSuccess: dto => dto,
                            onFailure: dto => throw new Exception("Não foi possível obter o dto")
                           );

                        rouboDto = resultDto;
                        assaltoDto = null;
                        agressaoDto = null;
                    }
                    else if ((string)ocorrencia["tipo"] == "AGRESSAO")
                    {
                        var id = (int)ocorrencia["agressao"];

                        var idPublic = _hashidsPublicIdService.ToPublic(id);

                        var dtoAgressao = await _agressaoService.GetByIdAsync(idPublic);

                        var resultDto = dtoAgressao.Map(
                            onSuccess: dto => dto,
                            onFailure: dto => throw new Exception("Não foi possível obter o dto")
                           );

                        agressaoDto = resultDto;
                        rouboDto = null;
                        assaltoDto = null;
                    }

                    var idLocalizacaoPublic = _hashidsPublicIdService.ToPublic((int)ocorrencia["id_localizacao"]);

                    var idUsuarioPublic = _hashidsPublicIdService.ToPublic((int)ocorrencia["id_usuario"]);

                    var dtoLocalizacao = await _localizacaoService.GetByIdAsync(idLocalizacaoPublic);

                    var resultDtoLocalizacao = dtoLocalizacao.Map(
                           onSuccess: dto => dto,
                           onFailure: dto => throw new Exception("Não foi possível obter o dto")
                          );

                    var dto = new OcorrenciaDto()
                        {
                            Id = _hashidsPublicIdService.ToPublic((int)ocorrencia["ocorrencia"]),
                            DataHora = ((DateTime)ocorrencia["datahora"]).ToLocalTime(), //No banco de dados está armazenado em UTC, preciso converter para horário local
                            Descricao = (string)ocorrencia["descricao"],
                            Agressao = agressaoDto,
                            Assalto = assaltoDto,
                            Roubo = rouboDto,
                            Localizacao = resultDtoLocalizacao,
                            UsuarioId = idUsuarioPublic
                    };

                    dtos.Add(dto);
                }

                return Result<IReadOnlyList<OcorrenciaDto>>.Success(dtos.AsReadOnly());
            }
            catch (Exception ex)
            {
                return Result<IReadOnlyList<OcorrenciaDto>>.Failure(new ErrorDefault(ex.Message));
            }

        }
    }
}
