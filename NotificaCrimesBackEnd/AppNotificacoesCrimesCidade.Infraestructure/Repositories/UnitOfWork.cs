using AppNotificacoesCrimesCidade.Domain.Interfaces;
using AppNotificacoesCrimesCidade.Infraestructure.Context;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Infraestructure.Repositories
{
    public class UnitOfWork : IUnitOfWork
    {
        public UnitOfWork(AppDbContext context)
        {
            _context = context;
        }

        public AppDbContext _context;


        //Abordagem lazy loading
        //Significa que estou adiando a criação do meu objeto até que seja de fato necessária
        private IAgressaoRepository? _agressaoRepository;     

        public IAgressaoRepository AgressaoRepository
        {
            get
            {
                return _agressaoRepository = _agressaoRepository ?? new AgressaoRepository(_context);
            }
        }

        private IAssaltoRepository? _assaltoRepository;

        public IAssaltoRepository AssaltoRepository
        {
            get
            {
                return _assaltoRepository = _assaltoRepository ?? new AssaltoRepository(_context);
            }
        }

        private IOcorrenciaRepository? _ocorrenciaRepository;

        public IOcorrenciaRepository OcorrenciaRepository
        {
            get
            {
                return _ocorrenciaRepository = _ocorrenciaRepository ?? new OcorrenciaRepository(_context);
            }
        }

        private ILocalizacaoOcorrenciaRepository? _localizacaoOcorrenciaRepository;

        public ILocalizacaoOcorrenciaRepository LocalizacaoOcorrenciaRepository
        {
            get
            {
                return _localizacaoOcorrenciaRepository = _localizacaoOcorrenciaRepository ?? new LocalizacaoOcorrenciaRepository(_context);
            }
        }

        private ITipoBemRepository? _tipoBemRepository;

        public ITipoBemRepository TipoBemRepository
        {
            get
            {
                return _tipoBemRepository = _tipoBemRepository ?? new TipoBemRepository(_context);
            }
        }

        public async Task<int> CommitAsync()
        {
            return await _context.SaveChangesAsync();
        }

        public async ValueTask DisposeAsync()
        {
            await _context.DisposeAsync();
        }
    }
}
