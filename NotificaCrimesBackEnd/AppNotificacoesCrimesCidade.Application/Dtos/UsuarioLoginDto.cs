using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Dtos
{
    public class UsuarioLoginDto
    {
        public string Token { get; set; }

        public string RefreshToken { get; set; }

        public DateTime Expiration { get; set; }

        public string Usuario { get; set; }

        public string Email { get; set; }

        public byte[]? Foto { get; set; }
    }
}
