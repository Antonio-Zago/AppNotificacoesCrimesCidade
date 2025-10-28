using NetTopologySuite.Geometries;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Domain.Entities
{
    public class LocalizacaoOcorrencia
    {
        [Column("id")]
        public int Id { get; set; }

        [Column("cep")]
        public string? cep { get; set; }

        [Column("coordenadas")]
        public Point Coordenadas { get; set; }

        [Column("cidade")]
        public string? Cidade { get; set; }

        [Column("bairro")]
        public string? Bairro { get; set; }

        [Column("rua")]
        public string? Rua { get; set; }

        [Column("numero")]
        public int Numero { get; set; }
    }
}
