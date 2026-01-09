using AppNotificacoesCrimesCidade.Application.Dtos;
using AppNotificacoesCrimesCidade.Application.Dtos.PlaceDetail;
using AppNotificacoesCrimesCidade.Application.Dtos.PlacePrediction;
using AppNotificacoesCrimesCidade.Application.Exceptions;
using AppNotificacoesCrimesCidade.Application.Helpers;
using AppNotificacoesCrimesCidade.Application.Interfaces;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;

namespace AppNotificacoesCrimesCidade.Application.Services
{
    public class PlacePredictionService : IPlacePredictionService
    {
        private readonly HttpClient _httpClient;

        public PlacePredictionService(HttpClient httpClient)
        {
            _httpClient = httpClient;
        }

        public async Task<Result<PlacesAutoCompleteDto>> Autocomplete(PlacePredictionRequestForm request)
        {
            try
            {
                CenterForm centerForm = new CenterForm()
                {
                    Latitude = request.Latitude,
                    Longitude = request.Longitude
                };

                CircleForm circleForm = new CircleForm()
                {
                    Center = centerForm
                };

                LocationBiasForm locationBiasForm = new LocationBiasForm()
                {
                    Circle = circleForm
                };

                PlacePredictionForm placePredictionForm = new PlacePredictionForm()
                {
                    Input = request.Input,
                    SessionToken = request.SessionToken,
                    LocationBias = locationBiasForm
                };

                var httpRequest = new HttpRequestMessage(
                HttpMethod.Post,
                "https://places.googleapis.com/v1/places:autocomplete"
                );

                var apiKey = Environment.GetEnvironmentVariable("GOOGLE_PLACES_API_KEY");

                httpRequest.Headers.Add("X-Goog-Api-Key", apiKey);

                httpRequest.Content = new StringContent(
                    JsonSerializer.Serialize(placePredictionForm),
                    Encoding.UTF8,
                    "application/json"
                );

                var response = await _httpClient.SendAsync(httpRequest);
                var json = await response.Content.ReadAsStringAsync();

                var result = JsonSerializer.Deserialize<PlacesAutoCompleteDto>(
                    json,
                    new JsonSerializerOptions { PropertyNameCaseInsensitive = true }
                );

                return Result<PlacesAutoCompleteDto>.Success(result);

            }
            catch (Exception ex)
            {
                return Result<PlacesAutoCompleteDto>.Failure(new ErrorDefault(ex.Message));
            }
        }

        public async Task<Result<PlaceDetailDto>> PlaceDetail(PlaceDetailForm request)
        {
            try
            {
                var httpRequest = new HttpRequestMessage(
                HttpMethod.Get,
                $"https://places.googleapis.com/v1/places/{request.PlaceId}?sessionToken={request.SessionId}"
                );


                var apiKey = Environment.GetEnvironmentVariable("GOOGLE_PLACES_API_KEY");

                httpRequest.Headers.Add("X-Goog-Api-Key", apiKey);
                httpRequest.Headers.Add("X-Goog-FieldMask", "id,displayName,location");

                var response = await _httpClient.SendAsync(httpRequest);
                var json = await response.Content.ReadAsStringAsync();

                var result = JsonSerializer.Deserialize<PlaceDetailDto>(
                    json,
                    new JsonSerializerOptions { PropertyNameCaseInsensitive = true }
                );

                return Result<PlaceDetailDto>.Success(result);

            }
            catch (Exception ex)
            {
                return Result<PlaceDetailDto>.Failure(new ErrorDefault(ex.Message));
            }
        }
    }
}
