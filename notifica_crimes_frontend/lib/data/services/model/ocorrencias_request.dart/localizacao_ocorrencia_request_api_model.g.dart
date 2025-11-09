// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'localizacao_ocorrencia_request_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalizacaoOcorrenciaRequestApiModel
_$LocalizacaoOcorrenciaRequestApiModelFromJson(Map<String, dynamic> json) =>
    LocalizacaoOcorrenciaRequestApiModel(
      json['cep'] as String?,
      json['cidade'] as String?,
      json['bairro'] as String?,
      json['rua'] as String?,
      (json['numero'] as num?)?.toInt(),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$LocalizacaoOcorrenciaRequestApiModelToJson(
  LocalizacaoOcorrenciaRequestApiModel instance,
) => <String, dynamic>{
  'cep': instance.cep,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'cidade': instance.cidade,
  'bairro': instance.bairro,
  'rua': instance.rua,
  'numero': instance.numero,
};
