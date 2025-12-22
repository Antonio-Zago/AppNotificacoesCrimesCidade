using AppNotificacoesCrimesCidade.Application.Dtos;
using AppNotificacoesCrimesCidade.Application.Helpers;
using AppNotificacoesCrimesCidade.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Interfaces
{
    public interface ILocalService : IServiceBase<Local, LocalDto, LocalForm>
    {
        Task<Result<IReadOnlyList<LocalDto>>> GetAllByEmail(string email);

        Task<Result<bool>> EnviarNotificacoes(double latitude, double longitude, int usuarioId);
    }
}
