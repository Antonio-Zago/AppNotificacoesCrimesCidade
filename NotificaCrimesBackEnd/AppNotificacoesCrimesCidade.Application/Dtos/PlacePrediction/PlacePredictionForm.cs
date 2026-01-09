using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Dtos.PlacePrediction
{
    public class PlacePredictionForm
    {
        [JsonPropertyName("input")]
        public string Input { get; set; }

        [JsonPropertyName("sessionToken")]
        public string SessionToken { get; set; }

        [JsonPropertyName("locationBias")]
        public LocationBiasForm LocationBias { get; set; }
    }
}
