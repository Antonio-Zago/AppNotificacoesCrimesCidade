using AppNotificacoesCrimesCidade.Domain.Entities;
using AppNotificacoesCrimesCidade.Domain.Interfaces;
using AppNotificacoesCrimesCidade.Infraestructure.Context;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Infraestructure.Repositories
{
    public class TipoArmaRepository : Repository<TipoArma>, ITipoArmaRepository
    {
        public TipoArmaRepository(AppDbContext context) : base(context)
        {
        }
    }
}
