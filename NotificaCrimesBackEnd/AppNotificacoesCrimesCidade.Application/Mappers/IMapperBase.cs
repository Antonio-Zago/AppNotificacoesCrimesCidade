using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Mappers
{
    public interface IMapperBase<T, U, F> where T : class where U : class where F : class
    {
        U ConvertToDto(T entidade);

        T ConvertToEntity(F form);

        void SetValuesUpdate(F form, T entity);
    }
}
