// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequestApiModel _$RegisterRequestApiModelFromJson(
  Map<String, dynamic> json,
) => RegisterRequestApiModel(
  nome: json['nome'] as String,
  email: json['email'] as String,
  senha: json['senha'] as String,
);

Map<String, dynamic> _$RegisterRequestApiModelToJson(
  RegisterRequestApiModel instance,
) => <String, dynamic>{
  'nome': instance.nome,
  'email': instance.email,
  'senha': instance.senha,
};
