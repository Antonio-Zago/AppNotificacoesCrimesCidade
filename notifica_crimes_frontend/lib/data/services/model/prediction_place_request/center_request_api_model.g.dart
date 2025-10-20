// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'center_request_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CenterRequestApiModel _$CenterRequestApiModelFromJson(
  Map<String, dynamic> json,
) => CenterRequestApiModel(
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
);

Map<String, dynamic> _$CenterRequestApiModelToJson(
  CenterRequestApiModel instance,
) => <String, dynamic>{
  'latitude': instance.latitude,
  'longitude': instance.longitude,
};
