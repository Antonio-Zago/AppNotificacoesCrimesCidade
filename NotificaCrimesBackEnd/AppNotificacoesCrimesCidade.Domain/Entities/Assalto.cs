using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Domain.Entities
{
    public class Assalto
    {
        [Column("id")]
        public int Id { get; set; }

        [Column("qtd_agressores")]
        public int QtdAgressores { get; set; }

        [Column("possui_arma")]
        public bool PossuiArma { get; set; }

        [Column("id_ocorrencia")]
        public int OcorrenciaId { get; set; }

        public Ocorrencia Ocorrencia { get; set; }

        [Column("tentativa")]
        public bool Tentativa { get; set; }

        [Column("id_tipo_arma")]
        public int? TipoArmaId { get; set; }

        public TipoArma TipoArma { get; set; }

        public List<AssaltoTipoBem> AssaltoTipoBens { get; set; }
    }
}
