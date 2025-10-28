using AppNotificacoesCrimesCidade.Domain.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Interfaces
{
    public interface IServiceFactory
    {
        IRepository<T> Create<T>() where T : class;
    }
}
