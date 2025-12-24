// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuracao_response_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfiguracaoResponseApiModel _$ConfiguracaoResponseApiModelFromJson(
  Map<String, dynamic> json,
) => ConfiguracaoResponseApiModel(
  notificaLocalizacao: json['notificaLocalizacao'] as bool,
  notificaLocal: json['notificaLocal'] as bool,
  distanciaLocalizacao: (json['distanciaLocalizacao'] as num).toDouble(),
  distanciaLocal: (json['distanciaLocal'] as num).toDouble(),
);

Map<String, dynamic> _$ConfiguracaoResponseApiModelToJson(
  ConfiguracaoResponseApiModel instance,
) => <String, dynamic>{
  'notificaLocalizacao': instance.notificaLocalizacao,
  'notificaLocal': instance.notificaLocal,
  'distanciaLocalizacao': instance.distanciaLocalizacao,
  'distanciaLocal': instance.distanciaLocal,
};
