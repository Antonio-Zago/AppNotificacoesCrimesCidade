using AppNotificacoesCrimesCidade.Domain.Entities;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Dtos
{
    public class AssaltoDto
    {
        public string? Id { get; set; }

        public int QtdAgressores { get; set; }

        public bool PossuiArma { get; set; }

        public string OcorrenciaId { get; set; }

        public bool Tentativa { get; set; }

        public string? TipoArmaId { get; set; }

    }
}
