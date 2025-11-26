import 'package:json_annotation/json_annotation.dart';
import 'package:notifica_crimes_frontend/data/services/model/prediction_place_response/text_prediction_api_model.dart';

part 'assalto_api_model.g.dart';

@JsonSerializable()
class AssaltoApiModel {

  AssaltoApiModel({required this.id, required this.qtdAgressores, required this.possuiArma, required this.ocorrenciaId, required this.tentativa, required this.tipoArmaId});

  final String id;
  final int qtdAgressores;
  final bool possuiArma;
  final String ocorrenciaId;
  final bool tentativa;
  final String? tipoArmaId;
  
  Map<String, dynamic> toJson() => _$AssaltoApiModelToJson(this);

  factory AssaltoApiModel.fromJson(Map<String, dynamic> json) => _$AssaltoApiModelFromJson(json);

  
}