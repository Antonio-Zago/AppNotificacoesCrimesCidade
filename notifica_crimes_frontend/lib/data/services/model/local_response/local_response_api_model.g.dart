// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_response_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalResponseApiModel _$LocalResponseApiModelFromJson(
  Map<String, dynamic> json,
) => LocalResponseApiModel(
  id: json['id'] as String,
  nome: json['nome'] as String,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
);

Map<String, dynamic> _$LocalResponseApiModelToJson(
  LocalResponseApiModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'nome': instance.nome,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
};
