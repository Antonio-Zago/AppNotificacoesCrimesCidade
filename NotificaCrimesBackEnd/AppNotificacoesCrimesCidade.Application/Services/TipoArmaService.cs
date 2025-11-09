using AppNotificacoesCrimesCidade.Application.Dtos;
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
    public class TipoArmaService : ServiceBase<TipoArma, TipoArmaDto, TipoArmaForm>, ITipoArmaService
    {
        public TipoArmaService(IServiceFactory serviceFactory, IUnitOfWork unitOfWork, IHashidsPublicIdService hashidsPublicIdService, IMapperBase<TipoArma, TipoArmaDto, TipoArmaForm> mapper) : base(serviceFactory, unitOfWork, hashidsPublicIdService, mapper)
        {
        }
    }
}
