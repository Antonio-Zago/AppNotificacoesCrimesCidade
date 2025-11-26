// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'localizacao_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalizacaoApiModel _$LocalizacaoApiModelFromJson(Map<String, dynamic> json) =>
    LocalizacaoApiModel(
      id: json['id'] as String,
      cep: json['cep'] as String?,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      cidade: json['cidade'] as String?,
      bairro: json['bairro'] as String?,
      rua: json['rua'] as String?,
      numero: (json['numero'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LocalizacaoApiModelToJson(
  LocalizacaoApiModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'cep': instance.cep,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'cidade': instance.cidade,
  'bairro': instance.bairro,
  'rua': instance.rua,
  'numero': instance.numero,
};
