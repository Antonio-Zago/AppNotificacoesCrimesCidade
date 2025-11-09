
import 'package:json_annotation/json_annotation.dart';
import 'package:notifica_crimes_frontend/data/services/model/ocorrencias_request.dart/localizacao_ocorrencia_request_api_model.dart';

part 'ocorrencia_request_api_model.g.dart';

@JsonSerializable()
class OcorrenciaRequestApiModel {

  OcorrenciaRequestApiModel({required this.descricao, required this.dataHora, required this.localizacao   });

  final String descricao;
  final DateTime dataHora;
  final LocalizacaoOcorrenciaRequestApiModel localizacao;
  
  Map<String, dynamic> toJson() => _$OcorrenciaRequestApiModelToJson(this);

  factory OcorrenciaRequestApiModel.fromJson(Map<String, dynamic> json) => _$OcorrenciaRequestApiModelFromJson(json);
}