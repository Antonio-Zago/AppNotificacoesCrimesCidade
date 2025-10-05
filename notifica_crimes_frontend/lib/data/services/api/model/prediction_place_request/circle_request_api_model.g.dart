// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'circle_request_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CircleRequestApiModel _$CircleRequestApiModelFromJson(
  Map<String, dynamic> json,
) => CircleRequestApiModel(
  radius: (json['radius'] as num).toInt(),
  center: CenterRequestApiModel.fromJson(
    json['center'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$CircleRequestApiModelToJson(
  CircleRequestApiModel instance,
) => <String, dynamic>{'center': instance.center, 'radius': instance.radius};
