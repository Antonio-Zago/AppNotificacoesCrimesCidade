using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Domain.Entities
{
    public class Roubo
    {
        [Column("id")]
        public int Id { get; set; }

        [Column("id_ocorrencia")]
        public int OcorrenciaId { get; set; }

        public Ocorrencia Ocorrencia { get; set; }

        [Column("tentativa")]
        public bool Tentativa { get; set; }

        public List<RouboTipoBem> RouboTipoBens { get; set; }
    }
}
