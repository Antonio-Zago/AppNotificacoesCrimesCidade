using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Dtos
{
    public class UsuarioConfiguracoesDto
    {
        public bool NotificaLocalizacao { get; set; }

        public bool NotificaLocal { get; set; }

        public double DistanciaLocalizacao { get; set; }

        public double DistanciaLocal { get; set; }
    }
}
