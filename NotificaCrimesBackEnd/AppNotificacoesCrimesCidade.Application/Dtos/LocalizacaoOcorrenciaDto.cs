using NetTopologySuite.Geometries;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Dtos
{
    public class LocalizacaoOcorrenciaDto
    {
        public String? Id { get; set; }

        public string? cep { get; set; }

        public double Latitude { get; set; }
        public double Longitude { get; set; }

        public string? Cidade { get; set; }

        public string? Bairro { get; set; }

        public string? Rua { get; set; }

        public int Numero { get; set; }
    }
}
