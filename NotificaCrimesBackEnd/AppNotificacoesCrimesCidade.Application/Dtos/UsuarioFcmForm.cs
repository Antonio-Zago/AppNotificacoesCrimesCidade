using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Dtos
{
    public class UsuarioFcmForm
    {
        public string Email { get; set; }

        public string TokenFcm { get; set; }
    }
}
