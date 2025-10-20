// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lat_lng_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LatLngApiModel _$LatLngApiModelFromJson(Map<String, dynamic> json) =>
    LatLngApiModel(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$LatLngApiModelToJson(LatLngApiModel instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
