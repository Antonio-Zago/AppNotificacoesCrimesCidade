using AppNotificacoesCrimesCidade.Domain.Entities;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Dtos
{
    public class LocalDto
    {
        public string Id { get; set; }

        public string Nome { get; set; }

        public double Latitude { get; set; }
        public double Longitude { get; set; }

    }
}
