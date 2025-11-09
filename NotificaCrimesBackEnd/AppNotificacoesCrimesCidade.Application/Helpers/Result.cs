using AppNotificacoesCrimesCidade.Application.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Helpers
{
    public class Result<T> : Result
    {
        private Result(T value)
        {
            Value = value;
            Error = null;
        }
        private Result(ErrorDefault errorDefault)
        {
            Value = default;
            Error = errorDefault;
        }

        public T? Value { get; set; }

        public ErrorDefault? Error { get; set; }

        public bool IsSuccess => Error == null;

        public static Result<T> Success(T value) => new Result<T>(value);

        public static Result<T> Failure(ErrorDefault error) => new Result<T>(error);

        public TResult Map<TResult>(Func<T, TResult> onSuccess, Func<ErrorDefault, TResult> onFailure)
        {
            return IsSuccess ? onSuccess(Value!) : onFailure(Error!);
        }
    }

    public class Result
    {
        public ErrorDefault? Error { get; }
        public bool IsSuccess => Error == null;

        protected Result(ErrorDefault? error = null)
        {
            Error = error;
        }
        public static Result Success() => new Result();
        public static Result Failure(ErrorDefault error) => new Result(error);
        public TResult Map<TResult>(Func<TResult> onSuccess, Func<ErrorDefault, TResult> onFailure)
        {
            return IsSuccess ? onSuccess() : onFailure(Error!);
        }
    }

}
