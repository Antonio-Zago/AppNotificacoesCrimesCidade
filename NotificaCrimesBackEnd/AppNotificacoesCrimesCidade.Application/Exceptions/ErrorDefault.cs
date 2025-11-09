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

        public string Message { get; set; }
    }
}
