using AppNotificacoesCrimesCidade.Application.Dtos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Interfaces
{
    public interface IServiceBase<TEntity, UDto, VForm> where TEntity : class, new() where UDto : class, new() where VForm : class, new()
    {
        Task<IReadOnlyList<UDto>> GetAllAsync();

        Task<UDto> AddAsync(VForm form);

        Task DeleteAsync(int id);

        Task<UDto> GetByIdAsync(int id);

        Task<UDto> UpdateAsync(VForm form, int id);
    }
}
