
import 'package:json_annotation/json_annotation.dart';
import 'package:notifica_crimes_frontend/data/services/api/model/prediction_place_request/location_bias_request_api_model.dart';

part 'place_prediction_request_api_model.g.dart';

@JsonSerializable()
class PlacePredictionRequestApiModel {
  PlacePredictionRequestApiModel({required this.input, required this.sessionToken, required this.locationBias});
  
  final String input;
  final String sessionToken;
  final LocationBiasRequestApiModel locationBias;

  Map<String, dynamic> toJson() => _$PlacePredictionRequestApiModelToJson(this);

  factory PlacePredictionRequestApiModel.fromJson(Map<String, dynamic> json) => _$PlacePredictionRequestApiModelFromJson(json);
}