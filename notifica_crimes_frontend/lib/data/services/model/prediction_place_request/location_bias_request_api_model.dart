
import 'package:json_annotation/json_annotation.dart';
import 'package:notifica_crimes_frontend/data/services/model/prediction_place_request/circle_request_api_model.dart';

part 'location_bias_request_api_model.g.dart';

@JsonSerializable()
class LocationBiasRequestApiModel {
  LocationBiasRequestApiModel({required this.circle});
  
  final CircleRequestApiModel circle;
  

  Map<String, dynamic> toJson() => _$LocationBiasRequestApiModelToJson(this);

  factory LocationBiasRequestApiModel.fromJson(Map<String, dynamic> json) => _$LocationBiasRequestApiModelFromJson(json);
}