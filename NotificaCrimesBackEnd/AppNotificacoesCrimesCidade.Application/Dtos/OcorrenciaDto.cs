using AppNotificacoesCrimesCidade.Domain.Entities;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Dtos
{
    public class OcorrenciaDto
    {
        public string? Id { get; set; }

        public string Descricao { get; set; }

        public DateTime DataHora { get; set; }

        public string? LocalizacaoId { get; set; }

    }
}
