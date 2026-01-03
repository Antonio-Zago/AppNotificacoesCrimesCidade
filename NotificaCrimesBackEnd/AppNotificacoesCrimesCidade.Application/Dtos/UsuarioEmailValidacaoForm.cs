using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Dtos
{
    public class UsuarioEmailValidacaoForm
    {
        public string Email { get; set; }

        public int? Codigo { get; set; }
    }
}
