using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Dtos
{
    public class PlacePredictionRequestForm
    {
        public string Input { get; set; }

        public double Latitude { get; set; }

        public double Longitude { get; set; }

        public string SessionToken { get; set; }
    }
}
