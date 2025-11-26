// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assalto_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssaltoApiModel _$AssaltoApiModelFromJson(Map<String, dynamic> json) =>
    AssaltoApiModel(
      id: json['id'] as String,
      qtdAgressores: (json['qtdAgressores'] as num).toInt(),
      possuiArma: json['possuiArma'] as bool,
      ocorrenciaId: json['ocorrenciaId'] as String,
      tentativa: json['tentativa'] as bool,
      tipoArmaId: json['tipoArmaId'] as String?,
    );

Map<String, dynamic> _$AssaltoApiModelToJson(AssaltoApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'qtdAgressores': instance.qtdAgressores,
      'possuiArma': instance.possuiArma,
      'ocorrenciaId': instance.ocorrenciaId,
      'tentativa': instance.tentativa,
      'tipoArmaId': instance.tipoArmaId,
    };
