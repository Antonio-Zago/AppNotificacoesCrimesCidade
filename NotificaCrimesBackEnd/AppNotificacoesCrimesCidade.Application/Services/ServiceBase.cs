using AppNotificacoesCrimesCidade.Application.Exceptions;
using AppNotificacoesCrimesCidade.Application.Helpers;
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


        private readonly IMapperBase<TEntity, UDto, VForm> _mapper;

        private readonly IHashidsPublicIdService _hashidsPublicIdService;

        public ServiceBase(IServiceFactory serviceFactory, IUnitOfWork unitOfWork, IHashidsPublicIdService hashidsPublicIdService, IMapperBase<TEntity, UDto, VForm> mapper)
        {
            _serviceFactory = serviceFactory;
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _hashidsPublicIdService = hashidsPublicIdService;
        }

        public virtual async Task<Result<IReadOnlyList<UDto>>> GetAllAsync()
        {
            try
            {
                var repositorio = _serviceFactory.Create<TEntity>();

                var entidades = await repositorio.GetAllAsync();

                var dtos = entidades.Select(e => _mapper.ConvertToDto(e)).ToList();


                return Result<IReadOnlyList<UDto>>.Success(dtos);
            }
            catch (Exception ex)
            {
                return Result<IReadOnlyList<UDto>>.Failure(new ErrorDefault(ex.Message));
            }

        }

        public virtual async Task<Result<UDto>> AddAsync(VForm form)
        {
            try
            {
                var repositorio = _serviceFactory.Create<TEntity>();

                var entidade = _mapper.ConvertToEntity(form);
        
                await _unitOfWork.BeginTransactionAsync();

                var entidadeSalva = await repositorio.AddAsync(entidade);

                await _unitOfWork.CommitAsync();

                var dto = _mapper.ConvertToDto(entidadeSalva);

                await _unitOfWork.CommitTransactionAsync(); 

                return Result<UDto>.Success( dto);
            }
            catch (Exception ex) 
            {
                await _unitOfWork.RoolbackTransactionAsync();
                return Result<UDto>.Failure(new ErrorDefault(ex.Message));
            }

            
        }

        public virtual async Task<Result>  DeleteAsync(string idPublic)
        {
            
            try
            {
                var repositorio = _serviceFactory.Create<TEntity>();

                await _unitOfWork.BeginTransactionAsync();

                var id = _hashidsPublicIdService.ToInternal(idPublic);

                if (id == null)
                {
                    throw new Exception("Falha na covernsão do id público");
                }
                  
                await repositorio.DeleteAsync(id.Value);

                await _unitOfWork.CommitAsync();

                await _unitOfWork.CommitTransactionAsync();

                return Result.Success();
            }
            catch (Exception ex)
            {
                await _unitOfWork.RoolbackTransactionAsync();
                return Result.Failure(new ErrorDefault(ex.Message));
            }

            
        }

        public virtual async Task<Result<UDto>> GetByIdAsync(string idPublic)
        {
            try
            {
                var repositorio = _serviceFactory.Create<TEntity>();

                var id = _hashidsPublicIdService.ToInternal(idPublic);

                if (id == null)
                {
                    throw new Exception("Falha na covernsão do id público");
                }

                var entity = await repositorio.GetByIdAsync(id.Value);
                if (entity == null)
                    throw new KeyNotFoundException($"Entidade {typeof(TEntity).Name} com ID {id} não encontrada.");

                var dto = _mapper.ConvertToDto(entity);

                return Result<UDto>.Success(dto);
            }
            catch (Exception ex)
            {
                return Result<UDto>.Failure(new ErrorDefault(ex.Message));
            }

        }

        public virtual async Task<Result<UDto>> UpdateAsync(VForm form, string idPublic)
        {
            
            try
            {
                var repositorio = _serviceFactory.Create<TEntity>();

                var id = _hashidsPublicIdService.ToInternal(idPublic);

                if (id == null)
                {
                    throw new Exception("Falha na covernsão do id público");
                }

                var entity = await repositorio.GetByIdAsync(id.Value);

                if (entity == null)
                    throw new KeyNotFoundException($"Entidade {typeof(TEntity).Name} com ID {id} não encontrada.");

                _mapper.SetValuesUpdate(form, entity);

                await _unitOfWork.BeginTransactionAsync();

                var entidadeSalva = await repositorio.UpdateAsync(entity);

                await _unitOfWork.CommitAsync();

                var dto = _mapper.ConvertToDto(entidadeSalva);

                await _unitOfWork.CommitTransactionAsync();

                return Result<UDto>.Success(dto);
            }
            catch (Exception ex)
            {
                await _unitOfWork.RoolbackTransactionAsync();
                return Result<UDto>.Failure(new ErrorDefault(ex.Message));
            }         
        }
    }
}
