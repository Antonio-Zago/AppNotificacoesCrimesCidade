import 'package:geolocator/geolocator.dart';
import 'package:notifica_crimes_frontend/domain/models/place_detail/place_detail.dart';
import 'package:notifica_crimes_frontend/domain/models/place_prediction/place_prediction.dart';
import 'package:result_dart/result_dart.dart';

abstract class MapRepository {
  Future<Result<List<PlacePrediction>>> requestAutoComplete(String text, double latitude, double longitude, String sessionId);
  Future<Result<PlaceDetail>> placeDetail(String placeId, String sessionId); 
  Future<Result<Position>> getLocalizacaoAtual();
}