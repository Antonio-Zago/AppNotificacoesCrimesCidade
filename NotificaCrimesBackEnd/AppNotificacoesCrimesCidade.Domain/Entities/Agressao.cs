using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Domain.Entities
{
    public class Agressao
    {
        [Column("id")]
        public int Id { get; set; }

        [Column("qtd_agressores")]
        public int QtdAgressores { get; set; }

        [Column("verbal")]
        public bool Verbal { get; set; }

        [Column("fisica")]
        public bool Fisica { get; set; }

        [Column("id_ocorrencia")]
        public int OcorrenciaId { get; set; }

        public Ocorrencia Ocorrencia { get; set; }

    }
}
