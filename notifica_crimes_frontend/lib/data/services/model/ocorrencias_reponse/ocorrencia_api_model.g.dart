// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ocorrencia_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OcorrenciaApiModel _$OcorrenciaApiModelFromJson(Map<String, dynamic> json) =>
    OcorrenciaApiModel(
      id: json['id'] as String,
      descricao: json['descricao'] as String,
      dataHora: LocalDateTimeConverter.fromJson(json['dataHora'] as String),
      localizacao: LocalizacaoApiModel.fromJson(
        json['localizacao'] as Map<String, dynamic>,
      ),
      assalto: json['assalto'] == null
          ? null
          : AssaltoApiModel.fromJson(json['assalto'] as Map<String, dynamic>),
      agressao: json['agressao'] == null
          ? null
          : AgressaoApiModel.fromJson(json['agressao'] as Map<String, dynamic>),
      roubo: json['roubo'] == null
          ? null
          : RouboApiModel.fromJson(json['roubo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OcorrenciaApiModelToJson(OcorrenciaApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'descricao': instance.descricao,
      'dataHora': LocalDateTimeConverter.toJson(instance.dataHora),
      'localizacao': instance.localizacao,
      'assalto': instance.assalto,
      'agressao': instance.agressao,
      'roubo': instance.roubo,
    };
