// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_bias_request_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationBiasRequestApiModel _$LocationBiasRequestApiModelFromJson(
  Map<String, dynamic> json,
) => LocationBiasRequestApiModel(
  circle: CircleRequestApiModel.fromJson(
    json['circle'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$LocationBiasRequestApiModelToJson(
  LocationBiasRequestApiModel instance,
) => <String, dynamic>{'circle': instance.circle};
