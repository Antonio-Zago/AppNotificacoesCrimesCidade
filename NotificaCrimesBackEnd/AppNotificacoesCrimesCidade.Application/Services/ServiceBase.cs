using AppNotificacoesCrimesCidade.Application.Interfaces;
using AppNotificacoesCrimesCidade.Application.Mappers;
using AppNotificacoesCrimesCidade.Domain.Interfaces;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Services
{
    public abstract class ServiceBase<TEntity, UDto, VForm> : IServiceBase<TEntity, UDto, VForm> where TEntity : class, new() where UDto : class, new() where VForm : class, new()
    {
        private readonly IServiceFactory _serviceFactory;

        private readonly IUnitOfWork _unitOfWork;

        public ServiceBase(IServiceFactory serviceFactory, IUnitOfWork unitOfWork)
        {
            _serviceFactory = serviceFactory;
            _unitOfWork = unitOfWork;
        }

        public virtual async Task<IReadOnlyList<UDto>> GetAllAsync()
        {
            var repositorio = _serviceFactory.Create<TEntity>();

            var entidades = await repositorio.GetAllAsync();

            var dtos = entidades.Select(e => MapperBase<TEntity, UDto>.ConvertToDto(e)).ToList();

            return dtos;
        }

        public virtual async Task<UDto> AddAsync(VForm form)
        {
            var repositorio = _serviceFactory.Create<TEntity>();

            var entidade = MapperBase<TEntity, VForm>.ConvertToEntity(form);

            var entidadeSalva = await repositorio.AddAsync(entidade);

            await _unitOfWork.CommitAsync();

            var dto = MapperBase<TEntity, UDto>.ConvertToDto(entidadeSalva);

            return dto;
        }

        public virtual async Task DeleteAsync(int id)
        {
            var repositorio = _serviceFactory.Create<TEntity>();

            await repositorio.DeleteAsync(id);

            await _unitOfWork.CommitAsync();
        }

        public virtual async Task<UDto> GetByIdAsync(int id)
        {
            var repositorio = _serviceFactory.Create<TEntity>();

            var entity = await repositorio.GetByIdAsync(id);
            if (entity == null)
                throw new KeyNotFoundException($"Entidade {typeof(TEntity).Name} com ID {id} não encontrada.");

            var dto = MapperBase<TEntity, UDto>.ConvertToDto(entity);

            return dto;
        }

        public virtual async Task<UDto> UpdateAsync(VForm form, int id)
        {
            var repositorio = _serviceFactory.Create<TEntity>();

            var entity = await repositorio.GetByIdAsync(id);

            if (entity == null)
                throw new KeyNotFoundException($"Entidade {typeof(TEntity).Name} com ID {id} não encontrada.");

            MapperBase<TEntity, VForm>.SetValuesUpdate(form, entity);

            var entidadeSalva = await repositorio.UpdateAsync(entity);

            await _unitOfWork.CommitAsync();

            var dto = MapperBase<TEntity, UDto>.ConvertToDto(entidadeSalva);

            return dto;
        }
    }
}
