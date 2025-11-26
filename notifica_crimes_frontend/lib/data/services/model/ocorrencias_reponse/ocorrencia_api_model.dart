import 'package:json_annotation/json_annotation.dart';
import 'package:notifica_crimes_frontend/data/services/model/ocorrencias_reponse/agressao_api_model.dart';
import 'package:notifica_crimes_frontend/data/services/model/ocorrencias_reponse/assalto_api_model.dart';
import 'package:notifica_crimes_frontend/data/services/model/ocorrencias_reponse/localizacao_api_model.dart';
import 'package:notifica_crimes_frontend/data/services/model/ocorrencias_reponse/roubo_api_model.dart';
import 'package:notifica_crimes_frontend/data/services/model/prediction_place_response/text_prediction_api_model.dart';

part 'ocorrencia_api_model.g.dart';

@JsonSerializable()
class OcorrenciaApiModel {

  OcorrenciaApiModel(  {required this.id, required this.descricao, required this.dataHora, required this.localizacao, required this.assalto, required this.agressao, required this.roubo});

  final String id;
  final String descricao;
  final DateTime dataHora;
  final LocalizacaoApiModel localizacao;
  final AssaltoApiModel? assalto;
  final AgressaoApiModel? agressao;
  final RouboApiModel? roubo;
  
  Map<String, dynamic> toJson() => _$OcorrenciaApiModelToJson(this);

  factory OcorrenciaApiModel.fromJson(Map<String, dynamic> json) => _$OcorrenciaApiModelFromJson(json);
}