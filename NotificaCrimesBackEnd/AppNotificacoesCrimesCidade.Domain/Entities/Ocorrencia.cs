using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Domain.Entities
{
    public class Ocorrencia
    {
        [Column("id")]
        public int Id { get; set; }

        [Column("descricao")]
        public string Descricao { get; set; }

        [Column("datahora")]
        public DateTime DataHora { get; set; }

        [Column("id_localizacao")]
        public int LocalizacaoId { get; set; }

        public LocalizacaoOcorrencia Localizacao { get; set; }

        [Column("id_usuario")]
        public int UsuarioId { get; set; }

        public Usuario Usuario { get; set; }
    }
}
