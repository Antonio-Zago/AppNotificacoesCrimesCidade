using AppNotificacoesCrimesCidade.Application.Dtos;
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

        public AssaltoService(IServiceFactory serviceFactory, IUnitOfWork unitOfWork) : base(serviceFactory, unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        public async override Task<AssaltoDto> AddAsync(AssaltoForm form)
        {

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
                DataHora = DateTime.SpecifyKind(form.Ocorrencia.DataHora, DateTimeKind.Utc),
                Localizacao = localizacaoOcorrencia
            };

            var listaTipoBens = new List<AssaltoTipoBem>();

            foreach (var idTipoBem in form.TipoBensId)
            {
                var tipoBem = await _unitOfWork.TipoBemRepository.GetByIdAsync(idTipoBem);
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

            var assalto = new Assalto()
            {
                Ocorrencia = ocorrencia,
                PossuiArma = form.PossuiArma,
                QtdAgressores = form.QtdAgressores,
                Tentativa = form.Tentativa,
                TipoArmaId = form.TipoArmaId,
                AssaltoTipoBens = listaTipoBens
            };

            var assaltoSalvo = await _unitOfWork.AssaltoRepository.AddAsync(assalto);

            await _unitOfWork.CommitAsync();

            return MapperBase<Assalto, AssaltoDto>.ConvertToDto(assaltoSalvo);
        }
    }
}
