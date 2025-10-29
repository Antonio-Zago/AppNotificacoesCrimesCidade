using NetTopologySuite.Geometries;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Dtos
{
    public class LocalizacaoOcorrenciaForm
    {
        public string? Cep { get; set; }

        public double Latitude { get; set; }
        public double Longitude { get; set; }

        public string? Cidade { get; set; }

        public string? Bairro { get; set; }

        public string? Rua { get; set; }

        public int Numero { get; set; }
    }
}
