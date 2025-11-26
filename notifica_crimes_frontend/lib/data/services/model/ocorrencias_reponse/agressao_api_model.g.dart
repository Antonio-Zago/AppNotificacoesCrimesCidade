// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agressao_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgressaoApiModel _$AgressaoApiModelFromJson(Map<String, dynamic> json) =>
    AgressaoApiModel(
      id: json['id'] as String,
      qtdAgressores: (json['qtdAgressores'] as num).toInt(),
      verbal: json['verbal'] as bool,
      ocorrenciaId: json['ocorrenciaId'] as String,
      fisica: json['fisica'] as bool,
    );

Map<String, dynamic> _$AgressaoApiModelToJson(AgressaoApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'qtdAgressores': instance.qtdAgressores,
      'verbal': instance.verbal,
      'fisica': instance.fisica,
      'ocorrenciaId': instance.ocorrenciaId,
    };
