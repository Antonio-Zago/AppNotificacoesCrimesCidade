
import 'package:json_annotation/json_annotation.dart';
import 'package:notifica_crimes_frontend/data/services/model/ocorrencias_request.dart/ocorrencia_request_api_model.dart';

part 'assalto_request_api_model.g.dart';

@JsonSerializable()
class AssaltoRequestApiModel {

  AssaltoRequestApiModel({required this.qtdAgressores, required this.possuiArma,required this.tentativa,required this.tipoArmaId,required this.tipoBensId, required this.ocorrencia   });

  final int qtdAgressores;
  final bool possuiArma;
  final bool tentativa;
  final String tipoArmaId;
  final List<String> tipoBensId;
  final OcorrenciaRequestApiModel ocorrencia;
  
  Map<String, dynamic> toJson() => _$AssaltoRequestApiModelToJson(this);

  factory AssaltoRequestApiModel.fromJson(Map<String, dynamic> json) => _$AssaltoRequestApiModelFromJson(json);
}