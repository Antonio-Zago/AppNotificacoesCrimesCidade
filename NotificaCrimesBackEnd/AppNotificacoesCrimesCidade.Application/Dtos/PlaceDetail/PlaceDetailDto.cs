using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Dtos.PlaceDetail
{
    public class PlaceDetailDto
    {
        [JsonPropertyName("id")]
        public string Id { get; set; }

        [JsonPropertyName("location")]
        public LatLngPlaceDetailDto Location { get; set; }
    }
}
