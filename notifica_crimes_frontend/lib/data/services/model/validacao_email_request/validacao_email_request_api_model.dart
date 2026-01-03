import 'package:json_annotation/json_annotation.dart';

part 'validacao_email_request_api_model.g.dart';

@JsonSerializable()
class ValidacaoEmailRequestApiModel {

  ValidacaoEmailRequestApiModel({required this.email, required this.codigo});

  final String email;
  final int? codigo;
  
  Map<String, dynamic> toJson() => _$ValidacaoEmailRequestApiModelToJson(this);

  factory ValidacaoEmailRequestApiModel.fromJson(Map<String, dynamic> json) => _$ValidacaoEmailRequestApiModelFromJson(json);

  
}