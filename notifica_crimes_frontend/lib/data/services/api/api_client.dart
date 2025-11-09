import 'package:dio/dio.dart';
import 'package:notifica_crimes_frontend/config/api_routes.dart';
import 'package:notifica_crimes_frontend/data/services/model/assalto_request/assalto_request_api_model.dart';
import 'package:notifica_crimes_frontend/data/services/model/ocorrencias_reponse/armas_api_model.dart';
import 'package:notifica_crimes_frontend/data/services/model/ocorrencias_reponse/bens_api_model.dart';
import 'package:notifica_crimes_frontend/data/services/model/place_detail_response/place_detail_api_model.dart';
import 'package:notifica_crimes_frontend/data/services/model/prediction_place_request/place_prediction_request_api_model.dart';
import 'package:notifica_crimes_frontend/data/services/model/prediction_place_response/place_prediction_api_model.dart';
import 'package:result_dart/result_dart.dart';

class ApiClient {
  const ApiClient({required this.dio});

  final Dio dio;

  //Migrar esse código para o backend
  Future<Result<List<PlacePredictionApiModel>>> requestAutoComplete(
    PlacePredictionRequestApiModel request,
  ) async {
    try {
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

      if (suggestions == null) {
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
    } on Exception catch (exception) {
      return Failure(Exception(exception));
    }
  }

  Future<Result<void>> postAssalto(AssaltoRequestApiModel request) async {
    try {
      var retorno = await dio.post(
        '${ApiRoutes.urlBase}/Assalto',
        data: request.toJson(),
      );

      return Success(Null);
    } on DioException catch (exception) {
      return Failure(_handleDioError(exception));
    } on Exception catch (exception) {
      return Failure(Exception(exception));
    }
  }

  Exception _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return Exception("Tempo de conexão expirado.");
      case DioExceptionType.sendTimeout:
        return Exception('Tempo de envio expirado.');
      case DioExceptionType.receiveTimeout:
        return Exception('Tempo de resposta expirado.');
      case DioExceptionType.badResponse:
        // Erros HTTP (ex: 400, 404, 500)
        final statusCode = e.response?.statusCode;
        final message =
            e.response?.data?['message'] ??
            'Erro na resposta do servidor ($statusCode).';
        return Exception(message);
      case DioExceptionType.cancel:
        return Exception( 'Requisição cancelada.');
      case DioExceptionType.unknown:
        return Exception( 'Erro de rede ou servidor indisponível.');
      default:
        return Exception('Erro desconhecido.');
    }
  }

  Future<Result<PlaceDetailApiModel>> placeDetail(
    String placeId,
    String sessionId,
  ) async {
    try {
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
    } on Exception catch (exception) {
      return Failure(Exception(exception));
    }
  }

  Future<Result<List<ArmasApiModel>>> findAllArmas() async {
    try {
      List<ArmasApiModel> retorno = [];

      final listaResponse = await dio.get('${ApiRoutes.urlBase}/TipoArma');

      for (var response in listaResponse.data) {
        var arma = ArmasApiModel.fromJson(response);

        retorno.add(arma);
      }

      return Success(retorno);
    } on Exception catch (exception) {
      return Failure(Exception(exception));
    }
  }

  Future<Result<List<BensApiModel>>> findAllBens() async {
    try {
      List<BensApiModel> retorno = [];

      final listaResponse = await dio.get('${ApiRoutes.urlBase}/TipoBem');

      for (var response in listaResponse.data) {
        var bem = BensApiModel.fromJson(response);

        retorno.add(bem);
      }

      return Success(retorno);
    } on Exception catch (exception) {
      return Failure(Exception(exception));
    }
  }
}
