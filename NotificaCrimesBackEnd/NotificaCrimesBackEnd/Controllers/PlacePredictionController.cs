using AppNotificacoesCrimesCidade.Application.Dtos;
using AppNotificacoesCrimesCidade.Application.Dtos.PlaceDetail;
using AppNotificacoesCrimesCidade.Application.Dtos.PlacePrediction;
using AppNotificacoesCrimesCidade.Application.Interfaces;
using AppNotificacoesCrimesCidade.Application.Services;
using Microsoft.AspNetCore.Mvc;

namespace NotificaCrimesBackEnd.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class PlacePredictionController : ControllerBase
    {
        private readonly IPlacePredictionService _placeService;

        public PlacePredictionController(IPlacePredictionService placeService)
        {
            _placeService = placeService;
        }


        [HttpPost]
        [Route("autoComplete")]
        public async Task<ActionResult<PlacesAutoCompleteDto>> AutoComplete([FromBody] PlacePredictionRequestForm model)
        {
            var user = await _placeService.Autocomplete(model);

            return user.Map<ActionResult>(
                onSuccess: user => Ok(user),
                onFailure: err =>
                {
                    return BadRequest(err);
                }
               );
        }

        [HttpPost]
        [Route("placeDetail")]
        public async Task<ActionResult<PlaceDetailDto>> PlaceDetail([FromBody] PlaceDetailForm model)
        {
            var user = await _placeService.PlaceDetail(model);

            return user.Map<ActionResult>(
                onSuccess: user => Ok(user),
                onFailure: err =>
                {
                    return BadRequest(err);
                }
               );
        }

    }
}
