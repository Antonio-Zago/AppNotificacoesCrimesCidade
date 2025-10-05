
import 'package:json_annotation/json_annotation.dart';

part 'center_request_api_model.g.dart';

@JsonSerializable()
class CenterRequestApiModel {
  CenterRequestApiModel({required this.latitude, required this.longitude});
  
  final double latitude;
  final double longitude;

  Map<String, dynamic> toJson() => _$CenterRequestApiModelToJson(this);

  factory CenterRequestApiModel.fromJson(Map<String, dynamic> json) => _$CenterRequestApiModelFromJson(json);
}