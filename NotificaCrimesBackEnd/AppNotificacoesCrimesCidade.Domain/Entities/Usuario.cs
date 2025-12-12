using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Domain.Entities
{
    public class Usuario
    {
        [Column("id")]
        public int Id { get; set; }

        [Column("nome")]
        public string Nome { get; set; }

        [Column("email")]
        public string Email { get; set; }

        [Column("senha")]
        public string Senha { get; set; }

        [Column("refreshtoken")]
        public string? RefreshToken { get; set; }

        [Column("refreshtokenexpirytime")]
        public DateTime? RefreshTokenExpiryTime { get; set; }

        [Column("sessionid")]
        public Guid? SessionId { get; set; }

        [Column("fcmtoken")]
        public string? FcmToken { get; set; }
    }
}
