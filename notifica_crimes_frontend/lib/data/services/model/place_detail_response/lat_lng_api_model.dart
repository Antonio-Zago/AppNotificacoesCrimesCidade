
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lat_lng_api_model.g.dart';

@JsonSerializable()
class LatLngApiModel {
  LatLngApiModel({required this.latitude, required this.longitude});
  
  final double latitude;
  final double longitude;

  Map<String, dynamic> toJson() => _$LatLngApiModelToJson(this);

  factory LatLngApiModel.fromJson(Map<String, dynamic> json) => _$LatLngApiModelFromJson(json);
}