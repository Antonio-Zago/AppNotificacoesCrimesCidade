
import 'package:json_annotation/json_annotation.dart';
import 'package:notifica_crimes_frontend/data/services/model/place_detail_response/lat_lng_api_model.dart';

part 'place_detail_api_model.g.dart';

@JsonSerializable()
class PlaceDetailApiModel {
  PlaceDetailApiModel({required this.id, required this.location});
  
  final String id;
  final LatLngApiModel location;

  Map<String, dynamic> toJson() => _$PlaceDetailApiModelToJson(this);

  factory PlaceDetailApiModel.fromJson(Map<String, dynamic> json) => _$PlaceDetailApiModelFromJson(json);
}