// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_prediction_request_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlacePredictionRequestApiModel _$PlacePredictionRequestApiModelFromJson(
  Map<String, dynamic> json,
) => PlacePredictionRequestApiModel(
  input: json['input'] as String,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  sessionToken: json['sessionToken'] as String,
);

Map<String, dynamic> _$PlacePredictionRequestApiModelToJson(
  PlacePredictionRequestApiModel instance,
) => <String, dynamic>{
  'input': instance.input,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'sessionToken': instance.sessionToken,
};
