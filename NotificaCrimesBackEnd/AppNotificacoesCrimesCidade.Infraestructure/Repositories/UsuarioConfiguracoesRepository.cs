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
    public class UsuarioConfiguracoesRepository : Repository<UsuarioConfiguracoes>, IUsuarioConfiguracoesRepository
    {
        private readonly AppDbContext _context;

        public UsuarioConfiguracoesRepository(AppDbContext context) : base(context)
        {
            _context = context;
        }

        public async Task<UsuarioConfiguracoes?> FindByEmail(string email)
        {
            return await _context.UsuarioConfiguracoes.Include(a => a.Usuario).FirstOrDefaultAsync(u => u.Usuario.Email == email);
        }
    }
}
