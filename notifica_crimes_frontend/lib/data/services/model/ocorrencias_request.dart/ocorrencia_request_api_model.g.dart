// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ocorrencia_request_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OcorrenciaRequestApiModel _$OcorrenciaRequestApiModelFromJson(
  Map<String, dynamic> json,
) => OcorrenciaRequestApiModel(
  descricao: json['descricao'] as String,
  dataHora: DateTime.parse(json['dataHora'] as String),
  localizacao: LocalizacaoOcorrenciaRequestApiModel.fromJson(
    json['localizacao'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$OcorrenciaRequestApiModelToJson(
  OcorrenciaRequestApiModel instance,
) => <String, dynamic>{
  'descricao': instance.descricao,
  'dataHora': instance.dataHora.toIso8601String(),
  'localizacao': instance.localizacao,
};
