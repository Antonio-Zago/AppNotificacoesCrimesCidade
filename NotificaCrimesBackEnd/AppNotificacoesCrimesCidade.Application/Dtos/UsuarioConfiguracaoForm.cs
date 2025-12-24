using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Dtos
{
    public class UsuarioConfiguracaoForm
    {
        public string Email { get; set; }

        public bool NotificaLocalizacao { get; set; }

        public bool NotificaLocal { get; set; }

        public double DistanciaLocalizacao { get; set; }

        public double DistanciaLocal { get; set; }
    }
}
