using AppNotificacoesCrimesCidade.Domain.Entities;
using AppNotificacoesCrimesCidade.Domain.Interfaces;
using AppNotificacoesCrimesCidade.Infraestructure.Context;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Infraestructure.Repositories
{
    public class LocalRepository : Repository<Local>, ILocalRepository
    {
        private readonly AppDbContext _context;
        public LocalRepository(AppDbContext context) : base(context)
        {
            _context= context;
        }

        public async Task<List<Local>> GetAllByUserId(int userId)
        {
            return await _context.Locais.Where(u => u.UsuarioId == userId).ToListAsync();
        }
    }
}
