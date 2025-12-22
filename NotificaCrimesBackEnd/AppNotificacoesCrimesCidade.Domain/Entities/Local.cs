using NetTopologySuite.Geometries;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Domain.Entities
{
    public class Local
    {
        [Column("id")]
        public int Id { get; set; }

        [Column("nome")]
        public string Nome { get; set; }

        [Column("coordenadas")]
        public Point Coordenadas { get; set; }

        [Column("usuario_id")]
        public int UsuarioId { get; set; }

        public Usuario Usuario { get; set; }

        
    }
}
