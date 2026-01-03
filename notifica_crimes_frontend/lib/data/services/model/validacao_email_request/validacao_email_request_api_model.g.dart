// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validacao_email_request_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidacaoEmailRequestApiModel _$ValidacaoEmailRequestApiModelFromJson(
  Map<String, dynamic> json,
) => ValidacaoEmailRequestApiModel(
  email: json['email'] as String,
  codigo: (json['codigo'] as num?)?.toInt(),
);

Map<String, dynamic> _$ValidacaoEmailRequestApiModelToJson(
  ValidacaoEmailRequestApiModel instance,
) => <String, dynamic>{'email': instance.email, 'codigo': instance.codigo};
