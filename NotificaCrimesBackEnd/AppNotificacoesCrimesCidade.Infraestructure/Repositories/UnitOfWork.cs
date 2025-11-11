using AppNotificacoesCrimesCidade.Domain.Interfaces;
using AppNotificacoesCrimesCidade.Infraestructure.Context;
using Microsoft.EntityFrameworkCore.Storage;
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
        IDbContextTransaction? _transaction;


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

        private ITipoArmaRepository? _tipoArmaRepository;

        public ITipoArmaRepository TipoArmaRepository
        {
            get
            {
                return _tipoArmaRepository = _tipoArmaRepository ?? new TipoArmaRepository(_context);
            }
        }

        private IRouboRepository? _rouboRepository;

        public IRouboRepository RouboRepository
        {
            get
            {
                return _rouboRepository = _rouboRepository ?? new RouboRepository(_context);
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

        public async Task BeginTransactionAsync()
        {
            if (_transaction == null)
            {
                _transaction = await _context.Database.BeginTransactionAsync();
            }
        }

        public async Task CommitTransactionAsync()
        {
            if (_transaction != null)
            {
                await _context.SaveChangesAsync();
                await _transaction.CommitAsync();
                await _transaction.DisposeAsync();
                _transaction = null;
            }
        }

        public async Task RoolbackTransactionAsync()
        {
            if (_transaction != null)
            {
                await _transaction.RollbackAsync();
                await _transaction.DisposeAsync();
                _transaction = null;
            }
        }
    }
}
