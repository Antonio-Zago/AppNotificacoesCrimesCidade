using AppNotificacoesCrimesCidade.Domain.Entities;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Dtos
{
    public class OcorrenciaForm
    {
        public string Descricao { get; set; }

        public DateTime DataHora { get; set; }

        public LocalizacaoOcorrenciaForm Localizacao { get; set; }


    }
}
