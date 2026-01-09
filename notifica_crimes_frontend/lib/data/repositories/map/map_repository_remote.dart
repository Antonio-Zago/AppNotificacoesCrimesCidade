import 'package:geolocator/geolocator.dart';
import 'package:notifica_crimes_frontend/data/repositories/map/map_repository.dart';
import 'package:notifica_crimes_frontend/data/services/api/api_client.dart';
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
        latitude: latitude,
        longitude: longitude
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

      PlaceDetail placeDetail = PlaceDetail(
        id: placeDetailApiModel.id,
        location: latLng,
      );

      return Success(placeDetail);
    } on Exception catch (exception) {
      return Failure(Exception(exception));
    }
  }

  @override
  Future<Result<Position>> getLocalizacaoAtual() async {
    bool serviceEnabled;
    LocationPermission permission;

    try {
      // Verifica se o GPS está ligado
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Serviço de localização desativado');
      }

      // Verifica permissão
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Permissão de localização negada');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Permissão negada permanentemente');
      }

      // Obtém localização
      var localizacao = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.high)
      );
      return Success(localizacao);
    } on Exception catch (exception) {
      return Failure(Exception(exception));
    }
  }
}
