using AppNotificacoesCrimesCidade.Application.Dtos;
using AppNotificacoesCrimesCidade.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Mappers
{
    public static class MapperBase<T, U> where T : class, new() where U : class, new() 
    {
        public static U ConvertToDto(T entidade)
        {
            var dto = new U();

            // Mapear propriedades simples via reflection
            foreach (var prop in typeof(T).GetProperties())
            {
                var targetProp = typeof(U).GetProperty(prop.Name);
                if (targetProp != null && targetProp.CanWrite)
                {
                    targetProp.SetValue(dto, prop.GetValue(entidade));
                }
            }

            return dto;
        }

        public static T ConvertToEntity(U form)
        {
            var entidade = new T();

            // Mapear propriedades simples via reflection
            foreach (var prop in typeof(U).GetProperties())
            {
                var targetProp = typeof(T).GetProperty(prop.Name);
                if (targetProp != null && targetProp.CanWrite)
                {
                    targetProp.SetValue(entidade, prop.GetValue(form));
                }
            }

            return entidade;
        }

        public static void SetValuesUpdate(U form, T entity)
        {
            foreach (var prop in typeof(U).GetProperties())
            {
                var targetProp = typeof(T).GetProperty(prop.Name);
                if (targetProp != null && targetProp.CanWrite)
                {
                    targetProp.SetValue(entity, prop.GetValue(form));
                }
            }
        }
    }
}
