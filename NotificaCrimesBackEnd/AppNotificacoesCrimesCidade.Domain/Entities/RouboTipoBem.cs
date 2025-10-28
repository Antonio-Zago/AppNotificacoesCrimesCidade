using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Domain.Entities
{
    public class RouboTipoBem
    {
        [Column("id_roubo")]
        public int RouboId { get; set; }

        public Roubo Roubo { get; set; }

        [Column("id_tipo_bem")]
        public int TipoBemId { get; set; }

        public TipoBem TipoBem { get; set; }
    }
}
