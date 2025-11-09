// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assalto_request_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssaltoRequestApiModel _$AssaltoRequestApiModelFromJson(
  Map<String, dynamic> json,
) => AssaltoRequestApiModel(
  qtdAgressores: (json['qtdAgressores'] as num).toInt(),
  possuiArma: json['possuiArma'] as bool,
  tentativa: json['tentativa'] as bool,
  tipoArmaId: json['tipoArmaId'] as String,
  tipoBensId: (json['tipoBensId'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  ocorrencia: OcorrenciaRequestApiModel.fromJson(
    json['ocorrencia'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$AssaltoRequestApiModelToJson(
  AssaltoRequestApiModel instance,
) => <String, dynamic>{
  'qtdAgressores': instance.qtdAgressores,
  'possuiArma': instance.possuiArma,
  'tentativa': instance.tentativa,
  'tipoArmaId': instance.tipoArmaId,
  'tipoBensId': instance.tipoBensId,
  'ocorrencia': instance.ocorrencia,
};
