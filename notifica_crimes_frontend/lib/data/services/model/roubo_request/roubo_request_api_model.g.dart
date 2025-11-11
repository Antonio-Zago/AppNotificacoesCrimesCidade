// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roubo_request_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouboRequestApiModel _$RouboRequestApiModelFromJson(
  Map<String, dynamic> json,
) => RouboRequestApiModel(
  tentativa: json['tentativa'] as bool,
  tipoBensId: (json['tipoBensId'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  ocorrencia: OcorrenciaRequestApiModel.fromJson(
    json['ocorrencia'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$RouboRequestApiModelToJson(
  RouboRequestApiModel instance,
) => <String, dynamic>{
  'tentativa': instance.tentativa,
  'tipoBensId': instance.tipoBensId,
  'ocorrencia': instance.ocorrencia,
};
