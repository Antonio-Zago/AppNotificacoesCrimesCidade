// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_prediction_request_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlacePredictionRequestApiModel _$PlacePredictionRequestApiModelFromJson(
  Map<String, dynamic> json,
) => PlacePredictionRequestApiModel(
  input: json['input'] as String,
  sessionToken: json['sessionToken'] as String,
  locationBias: LocationBiasRequestApiModel.fromJson(
    json['locationBias'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$PlacePredictionRequestApiModelToJson(
  PlacePredictionRequestApiModel instance,
) => <String, dynamic>{
  'input': instance.input,
  'sessionToken': instance.sessionToken,
  'locationBias': instance.locationBias,
};
