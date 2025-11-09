using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Domain.Interfaces
{
    public interface IUnitOfWork : IAsyncDisposable
    {
        IAgressaoRepository AgressaoRepository { get; }

        IAssaltoRepository AssaltoRepository { get; }
        IOcorrenciaRepository OcorrenciaRepository { get; }

        ILocalizacaoOcorrenciaRepository LocalizacaoOcorrenciaRepository { get; }

        ITipoBemRepository TipoBemRepository { get; }

        ITipoArmaRepository TipoArmaRepository { get; }
        Task<int> CommitAsync();

        Task BeginTransactionAsync();

        Task CommitTransactionAsync();

        Task RoolbackTransactionAsync();
    }
}
