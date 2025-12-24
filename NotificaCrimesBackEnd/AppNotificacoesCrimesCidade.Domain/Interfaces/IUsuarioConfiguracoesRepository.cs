using AppNotificacoesCrimesCidade.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Domain.Interfaces
{
    public interface IUsuarioConfiguracoesRepository : IRepository<UsuarioConfiguracoes>
    {
        Task<UsuarioConfiguracoes?> FindByEmail(string email);
    }
}
