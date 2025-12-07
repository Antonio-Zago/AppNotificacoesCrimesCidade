// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequestApiModel _$LoginRequestApiModelFromJson(
  Map<String, dynamic> json,
) => LoginRequestApiModel(
  email: json['email'] as String,
  senha: json['senha'] as String,
);

Map<String, dynamic> _$LoginRequestApiModelToJson(
  LoginRequestApiModel instance,
) => <String, dynamic>{'email': instance.email, 'senha': instance.senha};
