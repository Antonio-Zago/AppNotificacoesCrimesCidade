// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_request_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalRequestApiModel _$LocalRequestApiModelFromJson(
  Map<String, dynamic> json,
) => LocalRequestApiModel(
  nome: json['nome'] as String,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  email: json['email'] as String,
);

Map<String, dynamic> _$LocalRequestApiModelToJson(
  LocalRequestApiModel instance,
) => <String, dynamic>{
  'nome': instance.nome,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'email': instance.email,
};
