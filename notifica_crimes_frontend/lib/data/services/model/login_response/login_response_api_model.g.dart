// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseApiModel _$LoginResponseApiModelFromJson(
  Map<String, dynamic> json,
) => LoginResponseApiModel(
  token: json['token'] as String,
  refreshToken: json['refreshToken'] as String,
  expiration: DateTime.parse(json['expiration'] as String),
  usuario: json['usuario'] as String,
  email: json['email'] as String,
);

Map<String, dynamic> _$LoginResponseApiModelToJson(
  LoginResponseApiModel instance,
) => <String, dynamic>{
  'token': instance.token,
  'refreshToken': instance.refreshToken,
  'expiration': instance.expiration.toIso8601String(),
  'usuario': instance.usuario,
  'email': instance.email,
};
