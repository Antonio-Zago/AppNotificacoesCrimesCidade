using AppNotificacoesCrimesCidade.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Domain.Interfaces
{
    public interface IUsuarioRepository : IRepository<Usuario>
    {
        Task<Usuario?> FindByEmail(string email);

        Task<Usuario?> FindByUserName(string userName);

        Task<Usuario?> FindByFcmToken(string fcmToken);
    }
}
