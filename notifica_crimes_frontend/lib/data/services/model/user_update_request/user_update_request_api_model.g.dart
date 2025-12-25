// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_update_request_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserUpdateRequestApiModel _$UserUpdateRequestApiModelFromJson(
  Map<String, dynamic> json,
) => UserUpdateRequestApiModel(
  email: json['email'] as String,
  nome: json['nome'] as String,
  foto: json['foto'] as String?,
);

Map<String, dynamic> _$UserUpdateRequestApiModelToJson(
  UserUpdateRequestApiModel instance,
) => <String, dynamic>{
  'email': instance.email,
  'nome': instance.nome,
  'foto': instance.foto,
};
