using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Dtos.PlacePrediction
{
    public class TextPredictionDto
    {
        public string Text { get; set; }

        public List<MatchesPredictionDto> Matches { get; set; }
    }
}
