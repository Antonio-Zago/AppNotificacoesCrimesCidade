using AppNotificacoesCrimesCidade.Domain.Entities;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Dtos
{
    public class RouboDto
    {
        public string Id { get; set; }

        public string OcorrenciaId { get; set; }

        public bool Tentativa { get; set; }
    }
}
