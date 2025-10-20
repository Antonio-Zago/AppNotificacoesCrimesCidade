import 'package:notifica_crimes_frontend/data/repositories/map/map_repository.dart';
import 'package:notifica_crimes_frontend/data/services/api/api_client.dart';
import 'package:notifica_crimes_frontend/data/services/model/prediction_place_request/center_request_api_model.dart';
import 'package:notifica_crimes_frontend/data/services/model/prediction_place_request/circle_request_api_model.dart';
import 'package:notifica_crimes_frontend/data/services/model/prediction_place_request/location_bias_request_api_model.dart';
import 'package:notifica_crimes_frontend/data/services/model/prediction_place_request/place_prediction_request_api_model.dart';
import 'package:notifica_crimes_frontend/domain/models/place_detail/lat_lng_place_detail.dart';
import 'package:notifica_crimes_frontend/domain/models/place_detail/place_detail.dart';
import 'package:notifica_crimes_frontend/domain/models/place_prediction/place_prediction.dart';
import 'package:result_dart/result_dart.dart';

class MapRepositoryRemote implements MapRepository {
  MapRepositoryRemote({required this.apiClient});

  final ApiClient apiClient;

  @override
  Future<Result<List<PlacePrediction>>> requestAutoComplete(
    String text,
    double latitude,
    double longitude,
    String sessionId,
  ) async {
    try {
      List<PlacePrediction> listaPlacePrediction = [];
      if (text.isEmpty) {
        return Success(listaPlacePrediction);
      }

      var request = PlacePredictionRequestApiModel(
        input: text,
        sessionToken: sessionId,
        locationBias: LocationBiasRequestApiModel(
          circle: CircleRequestApiModel(
            radius: 500,
            center: CenterRequestApiModel(
              latitude: latitude,
              longitude: longitude,
            ),
          ),
        ),
      );

      var response = await apiClient.requestAutoComplete(request);

      var listaPredicitons = response.getOrThrow();

      for (var apiModel in listaPredicitons) {
        PlacePrediction placePrediction = PlacePrediction(
          text: apiModel.text.text,
          placeId: apiModel.placeId,
        );

        listaPlacePrediction.add(placePrediction);
      }
      return Success(listaPlacePrediction);
    } on Exception catch (exception) {
      return Failure(Exception(exception));
    }
  }

  @override
  Future<Result<PlaceDetail>> placeDetail(
    String placeId,
    String sessionId,
  ) async {
    try {
      var apiModel = await apiClient.placeDetail(placeId, sessionId);

      var placeDetailApiModel = apiModel.getOrThrow();

      LatLngPlaceDetail latLng = LatLngPlaceDetail(
        latitude: placeDetailApiModel.location.latitude,
        longitude: placeDetailApiModel.location.longitude,
      );

      PlaceDetail placeDetail = PlaceDetail(id: placeDetailApiModel.id, location: latLng);

      return Success(placeDetail);
    } on Exception catch (exception) {
      return Failure(Exception(exception));
    }
  }
}
