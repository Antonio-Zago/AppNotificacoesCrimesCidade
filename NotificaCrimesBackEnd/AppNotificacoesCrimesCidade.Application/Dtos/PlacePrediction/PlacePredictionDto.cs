using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Dtos.PlacePrediction
{
    public class PlacePredictionDto
    {
        public string Place { get; set; }

        public string PlaceId { get; set; }

        public TextPredictionDto Text { get; set; }
    }
}
