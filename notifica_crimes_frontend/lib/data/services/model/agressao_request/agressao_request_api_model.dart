
import 'package:json_annotation/json_annotation.dart';
import 'package:notifica_crimes_frontend/data/services/model/ocorrencias_request.dart/ocorrencia_request_api_model.dart';

part 'agressao_request_api_model.g.dart';

@JsonSerializable()
class AgressaoRequestApiModel {

  AgressaoRequestApiModel({required this.qtdAgressores, required this.fisica,required this.verbal, required this.ocorrencia   });

  final int qtdAgressores;
  final bool fisica;
  final bool verbal;
  final OcorrenciaRequestApiModel ocorrencia;
  
  Map<String, dynamic> toJson() => _$AgressaoRequestApiModelToJson(this);

  factory AgressaoRequestApiModel.fromJson(Map<String, dynamic> json) => _$AgressaoRequestApiModelFromJson(json);
}