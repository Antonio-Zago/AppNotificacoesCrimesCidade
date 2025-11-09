using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Dtos
{
    public class TipoArmaDto
    {
        public string? Id { get; set; }

        public string Nome { get; set; }

        public bool ArmaFogo { get; set; }
    }
}
