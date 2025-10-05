
import 'package:json_annotation/json_annotation.dart';
import 'package:notifica_crimes_frontend/data/services/api/model/prediction_place_request/center_request_api_model.dart';

part 'circle_request_api_model.g.dart';

@JsonSerializable()
class CircleRequestApiModel {
  CircleRequestApiModel( {required this.radius, required this.center,});
  
  final CenterRequestApiModel center;
  final int radius;
  

  Map<String, dynamic> toJson() => _$CircleRequestApiModelToJson(this);

  factory CircleRequestApiModel.fromJson(Map<String, dynamic> json) => _$CircleRequestApiModelFromJson(json);
}