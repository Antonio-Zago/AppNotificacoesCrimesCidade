using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Exceptions
{
    public class ErrorDefault
    {
        public ErrorDefault(string message)
        {
            Message = message;
        }

        public ErrorDefault(string message, int statusCode)
        {
            Message = message;
            StatusCode = statusCode;
        }

        public string Message { get; set; }

        public int StatusCode { get; set; }
    }
}
