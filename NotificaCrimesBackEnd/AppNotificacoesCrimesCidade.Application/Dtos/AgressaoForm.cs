using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Dtos
{
    public class AgressaoForm
    {
        public int QtdAgressores { get; set; }

        public bool Verbal { get; set; }

        public bool Fisica { get; set; }

        public OcorrenciaForm Ocorrencia { get; set; }

    }
}
