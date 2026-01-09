using AppNotificacoesCrimesCidade.Application.Dtos;
using AppNotificacoesCrimesCidade.Application.Dtos.PlaceDetail;
using AppNotificacoesCrimesCidade.Application.Dtos.PlacePrediction;
using AppNotificacoesCrimesCidade.Application.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Interfaces
{
    public interface IPlacePredictionService
    {
        Task<Result<PlacesAutoCompleteDto>> Autocomplete(PlacePredictionRequestForm request);

        Task<Result<PlaceDetailDto>> PlaceDetail(PlaceDetailForm request);
    }
}
