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
    public class AgressaoService : ServiceBase<Agressao, AgressaoDto, AgressaoForm>, IAgressaoService
    {
        private readonly IUnitOfWork _unitOfWork;
        public AgressaoService(IServiceFactory serviceFactory, IUnitOfWork unitOfWork) : base(serviceFactory, unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        //Aqui eu consigo sobscrever os métodos do base caso tenha uma regra diferente a ser utilizada
        public override Task<IReadOnlyList<AgressaoDto>> GetAllAsync()
        {
            return base.GetAllAsync();
        }
    }
}
