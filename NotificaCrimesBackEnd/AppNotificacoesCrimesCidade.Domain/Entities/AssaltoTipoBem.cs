using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Domain.Entities
{
    public class AssaltoTipoBem
    {

        [Column("id_assalto")]
        public int AssaltoId { get; set; }

        public Assalto Assalto { get; set; }

        [Column("id_tipo_bem")]
        public int TipoBemId { get; set; }

        public TipoBem TipoBem { get; set; }
    }
}
