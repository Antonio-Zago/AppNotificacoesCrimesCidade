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
    public class OcorrenciaRepository : Repository<Ocorrencia>, IOcorrenciaRepository
    {
        public OcorrenciaRepository(AppDbContext context) : base(context)
        {
        }
    }
}
