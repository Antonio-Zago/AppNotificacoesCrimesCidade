using AppNotificacoesCrimesCidade.Application.Dtos;
using AppNotificacoesCrimesCidade.Application.Interfaces;
using AppNotificacoesCrimesCidade.Domain.Entities;
using AppNotificacoesCrimesCidade.Domain.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Services
{
    public class OcorrenciaService : ServiceBase<Ocorrencia, OcorrenciaDto, OcorrenciaForm>, IOcorrenciaService
    {
        public OcorrenciaService(IServiceFactory serviceFactory, IUnitOfWork unitOfWork) : base(serviceFactory, unitOfWork)
        {
        }
    }
}
