using AppNotificacoesCrimesCidade.Application.Dtos;
using AppNotificacoesCrimesCidade.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Interfaces
{
    public interface ITipoArmaService : IServiceBase<TipoArma, TipoArmaDto, TipoArmaForm>
    {
    }
}
