
import 'package:json_annotation/json_annotation.dart';
import 'package:notifica_crimes_frontend/data/services/model/place_detail_response/lat_lng_api_model.dart';

part 'place_detail_request_api_model.g.dart';

@JsonSerializable()
class PlaceDetailRequestApiModel {
  PlaceDetailRequestApiModel({required this.placeId, required this.sessionId});
  
  final String placeId;
  final String sessionId;

  Map<String, dynamic> toJson() => _$PlaceDetailRequestApiModelToJson(this);

  factory PlaceDetailRequestApiModel.fromJson(Map<String, dynamic> json) => _$PlaceDetailRequestApiModelFromJson(json);
}