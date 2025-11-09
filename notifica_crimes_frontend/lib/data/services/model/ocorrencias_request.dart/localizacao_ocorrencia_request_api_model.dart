
import 'package:json_annotation/json_annotation.dart';

part 'localizacao_ocorrencia_request_api_model.g.dart';

@JsonSerializable()
class LocalizacaoOcorrenciaRequestApiModel {

  LocalizacaoOcorrenciaRequestApiModel(this.cep, this.cidade, this.bairro, this.rua, this.numero, {required this.latitude, required this.longitude} );

  final String? cep;
  final double latitude;
  final double longitude;
  final String? cidade;
  final String? bairro;
  final String? rua;
  final int? numero;
  
  Map<String, dynamic> toJson() => _$LocalizacaoOcorrenciaRequestApiModelToJson(this);

  factory LocalizacaoOcorrenciaRequestApiModel.fromJson(Map<String, dynamic> json) => _$LocalizacaoOcorrenciaRequestApiModelFromJson(json);
}