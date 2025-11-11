using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Dtos
{
    public class RouboForm
    {
        public OcorrenciaForm Ocorrencia { get; set; }

        public bool Tentativa { get; set; }

        public List<string>? TipoBensId { get; set; }
    }
}
