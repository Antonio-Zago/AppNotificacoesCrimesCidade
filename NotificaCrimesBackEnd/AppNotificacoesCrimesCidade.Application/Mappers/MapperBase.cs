using AppNotificacoesCrimesCidade.Application.Dtos;
using AppNotificacoesCrimesCidade.Application.Interfaces;
using AppNotificacoesCrimesCidade.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Mappers
{
    public class MapperBase<T, U, F> : IMapperBase<T, U, F>  where T : class, new() where U : class, new() where F : class, new()
    {
        public MapperBase(IHashidsPublicIdService hashidsPublicIdService)
        {
            _hashidsPublicIdService = hashidsPublicIdService;
        }

        private readonly IHashidsPublicIdService _hashidsPublicIdService;

        public U ConvertToDto(T entidade)
        {
            var dto = new U();

            // Mapear propriedades simples via reflection
            foreach (var prop in typeof(T).GetProperties())
            {
                var targetProp = typeof(U).GetProperty(prop.Name);
                if (targetProp != null && targetProp.CanWrite)
                {
                    if (targetProp.Name.Contains("Id",StringComparison.Ordinal))
                    {
                        if (prop.GetValue(entidade) != null)
                        {
                            var idPublic = _hashidsPublicIdService.ToPublic((int)prop.GetValue(entidade));
                            targetProp.SetValue(dto, idPublic);
                        }         
                        
                    }
                    else
                    {
                        targetProp.SetValue(dto, prop.GetValue(entidade));
                    }
                        
                }
            }

            return dto;
        }

        public T ConvertToEntity(F form)
        {
            var entidade = new T();

            // Mapear propriedades simples via reflection
            foreach (var prop in typeof(F).GetProperties())
            {
                var targetProp = typeof(T).GetProperty(prop.Name);
                if (targetProp != null && targetProp.CanWrite)
                {
                    if (targetProp.Name.Contains("Id", StringComparison.Ordinal))
                    {
                        var id = _hashidsPublicIdService.ToInternal((string)prop.GetValue(form));

                        targetProp.SetValue(entidade, id);
                    }
                    else
                    {
                        targetProp.SetValue(entidade, prop.GetValue(form));
                    }

                }
            }

            return entidade;
        }

        public void SetValuesUpdate(F form, T entity)
        {
            foreach (var prop in typeof(F).GetProperties())
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
