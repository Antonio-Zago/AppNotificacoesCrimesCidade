using AppNotificacoesCrimesCidade.Application.Dtos;
using AppNotificacoesCrimesCidade.Application.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Interfaces
{
    public interface IServiceBase<TEntity, UDto, VForm> where TEntity : class, new() where UDto : class, new() where VForm : class, new()
    {
        Task<Result<IReadOnlyList<UDto>>> GetAllAsync();

        Task<Result<UDto>> AddAsync(VForm form);

        Task<Result> DeleteAsync(string id);

        Task<Result<UDto>> GetByIdAsync(string id);

        Task<Result<UDto>> UpdateAsync(VForm form, string id);
    }
}
