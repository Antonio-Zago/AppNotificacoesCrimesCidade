// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roubo_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouboApiModel _$RouboApiModelFromJson(Map<String, dynamic> json) =>
    RouboApiModel(
      id: json['id'] as String,
      tentativa: json['tentativa'] as bool,
      ocorrenciaId: json['ocorrenciaId'] as String,
    );

Map<String, dynamic> _$RouboApiModelToJson(RouboApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tentativa': instance.tentativa,
      'ocorrenciaId': instance.ocorrenciaId,
    };
