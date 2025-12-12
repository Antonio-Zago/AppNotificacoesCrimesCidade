// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fcm_request_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FcmRequestApiModel _$FcmRequestApiModelFromJson(Map<String, dynamic> json) =>
    FcmRequestApiModel(
      email: json['email'] as String,
      tokenFcm: json['tokenFcm'] as String,
    );

Map<String, dynamic> _$FcmRequestApiModelToJson(FcmRequestApiModel instance) =>
    <String, dynamic>{'email': instance.email, 'tokenFcm': instance.tokenFcm};
