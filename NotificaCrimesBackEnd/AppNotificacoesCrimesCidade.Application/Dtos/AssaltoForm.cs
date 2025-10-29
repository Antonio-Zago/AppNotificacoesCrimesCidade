using AppNotificacoesCrimesCidade.Domain.Entities;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Dtos
{
    public class AssaltoForm
    {
        public int QtdAgressores { get; set; }
        public bool PossuiArma { get; set; }
        public OcorrenciaForm Ocorrencia { get; set; }

        public bool Tentativa { get; set; }
        public int TipoArmaId { get; set; }

        public List<int> TipoBensId { get; set; }
    }
}
