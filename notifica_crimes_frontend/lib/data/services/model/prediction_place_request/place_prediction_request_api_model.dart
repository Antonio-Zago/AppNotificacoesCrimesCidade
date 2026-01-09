import 'package:json_annotation/json_annotation.dart';
import 'package:notifica_crimes_frontend/data/services/model/prediction_place_response/text_prediction_api_model.dart';

part 'place_prediction_request_api_model.g.dart';

@JsonSerializable()
class PlacePredictionRequestApiModel {

  PlacePredictionRequestApiModel( {required this.input, required this.latitude, required this.longitude, required this.sessionToken});

  final String input;
  final double latitude;
  final double longitude;
  final String sessionToken;
  
  Map<String, dynamic> toJson() => _$PlacePredictionRequestApiModelToJson(this);

  factory PlacePredictionRequestApiModel.fromJson(Map<String, dynamic> json) => _$PlacePredictionRequestApiModelFromJson(json);
}