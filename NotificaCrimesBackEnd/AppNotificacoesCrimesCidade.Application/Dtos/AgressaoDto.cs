using AppNotificacoesCrimesCidade.Domain.Entities;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Dtos
{
    public class AgressaoDto 
    {
        public int Id { get; set; }

        public int QtdAgressores { get; set; }

        public bool Verbal { get; set; }

        public bool Fisica { get; set; }

        public int OcorrenciaId { get; set; }
    }
}
