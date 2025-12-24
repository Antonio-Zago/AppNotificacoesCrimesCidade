// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuracoes_request_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfiguracoesRequestApiModel _$ConfiguracoesRequestApiModelFromJson(
  Map<String, dynamic> json,
) => ConfiguracoesRequestApiModel(
  email: json['email'] as String,
  notificaLocalizacao: json['notificaLocalizacao'] as bool,
  notificaLocal: json['notificaLocal'] as bool,
  distanciaLocalizacao: (json['distanciaLocalizacao'] as num).toDouble(),
  distanciaLocal: (json['distanciaLocal'] as num).toDouble(),
);

Map<String, dynamic> _$ConfiguracoesRequestApiModelToJson(
  ConfiguracoesRequestApiModel instance,
) => <String, dynamic>{
  'email': instance.email,
  'notificaLocalizacao': instance.notificaLocalizacao,
  'notificaLocal': instance.notificaLocal,
  'distanciaLocalizacao': instance.distanciaLocalizacao,
  'distanciaLocal': instance.distanciaLocal,
};
