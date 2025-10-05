import 'package:dio/dio.dart';
import 'package:notifica_crimes_frontend/data/services/api/model/place_detail_response/place_detail_api_model.dart';
import 'package:notifica_crimes_frontend/data/services/api/model/prediction_place_request/place_prediction_request_api_model.dart';
import 'package:notifica_crimes_frontend/data/services/api/model/prediction_place_response/place_prediction_api_model.dart';
import 'package:result_dart/result_dart.dart';

class ApiClient {
  const ApiClient({required this.dio});

  final Dio dio;

  //Migrar esse código para o backend
  Future<Result<List<PlacePredictionApiModel>>> requestAutoComplete(
    PlacePredictionRequestApiModel request,
  ) async {
    try{
      List<PlacePredictionApiModel> listaPlacePrediction = [];

      final response = await dio.post(
        'https://places.googleapis.com/v1/places:autocomplete',
        data: request.toJson(),
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "X-Goog-Api-Key": "",
          },
        ),
      );

      var suggestions = response.data["suggestions"];

      if(suggestions == null){
        return Success(listaPlacePrediction); 
      }

      for (var suggestion in suggestions) {
        var placePrediction = suggestion["placePrediction"];

        var placePredictionModel = PlacePredictionApiModel.fromJson(
          placePrediction,
        );
        listaPlacePrediction.add(placePredictionModel);
      }

      return Success(listaPlacePrediction);
    }
    on Exception catch(exception){
      return Failure(Exception(exception));
    }
    
  }

  Future<Result<PlaceDetailApiModel>> placeDetail(
    String placeId,
    String sessionId,
  ) async {
    try{
      final response = await dio.get(
        'https://places.googleapis.com/v1/places/$placeId',
        queryParameters: {"sessionToken": sessionId},
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "X-Goog-Api-Key": "",
            "X-Goog-FieldMask": "id,displayName,location",
          },
        ),
      );

      var placeDetail = PlaceDetailApiModel.fromJson(response.data);

      return Success(placeDetail);
    }on Exception catch(exception){
      return Failure(Exception(exception));
    } 
  }
}
