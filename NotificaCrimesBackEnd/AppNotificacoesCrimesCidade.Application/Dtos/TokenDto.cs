using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Dtos
{
    public class TokenDto
    {
        public string Token { get; set; }

        public string RefreshToken { get; set; }
    }
}
