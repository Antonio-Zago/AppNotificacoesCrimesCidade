// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agressao_request_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgressaoRequestApiModel _$AgressaoRequestApiModelFromJson(
  Map<String, dynamic> json,
) => AgressaoRequestApiModel(
  qtdAgressores: (json['qtdAgressores'] as num).toInt(),
  fisica: json['fisica'] as bool,
  verbal: json['verbal'] as bool,
  ocorrencia: OcorrenciaRequestApiModel.fromJson(
    json['ocorrencia'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$AgressaoRequestApiModelToJson(
  AgressaoRequestApiModel instance,
) => <String, dynamic>{
  'qtdAgressores': instance.qtdAgressores,
  'fisica': instance.fisica,
  'verbal': instance.verbal,
  'ocorrencia': instance.ocorrencia,
};
