using AppNotificacoesCrimesCidade.Application.Interfaces;
using AppNotificacoesCrimesCidade.Domain.Interfaces;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Services
{
    public class ServiceFactory : IServiceFactory
    {

        private readonly IUnitOfWork _unitOfWork;

        public ServiceFactory( IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        public IRepository<T> Create<T>() where T : class
        {
            // Procura no UnitOfWork uma propriedade cujo tipo seja IRepository<T>
            var repoPropertys = _unitOfWork
                .GetType()
                .GetProperties()
                .FirstOrDefault(p =>
                p.PropertyType.GetInterfaces().Any(i =>
                    i.IsGenericType &&
                    i.GetGenericTypeDefinition() == typeof(IRepository<>) &&
                    i.GetGenericArguments()[0] == typeof(T))
            );

            if (repoPropertys == null)
                throw new InvalidOperationException($"Nenhum repositório encontrado para o tipo {typeof(T).Name}.");

            return (IRepository<T>)repoPropertys.GetValue(_unitOfWork)!;
        }
    }
}
