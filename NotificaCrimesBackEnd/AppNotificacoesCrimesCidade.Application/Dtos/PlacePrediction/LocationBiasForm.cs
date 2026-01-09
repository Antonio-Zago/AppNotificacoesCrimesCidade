using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Dtos.PlacePrediction
{
    public class LocationBiasForm
    {
        [JsonPropertyName("circle")]
        public CircleForm Circle { get; set; }
    }
}
