using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Domain.Entities
{
    public class UsuarioConfiguracoes
    {
        [Column("id")]
        public int Id { get; set; }

        [Column("notifica_localizacao")]
        public bool NotificaLocalizacao { get; set; }

        [Column("notifica_local")]
        public bool NotificaLocal { get; set; }

        [Column("distancia_localizacao")]
        public double DistanciaLocalizacao { get; set; }

        [Column("distancia_local")]
        public double DistanciaLocal { get; set; }

        [Column("id_usuario")]
        public int UsuarioId { get; set; }

        public Usuario Usuario { get; set; }
    }
}
