import 'package:json_annotation/json_annotation.dart';
import 'package:notifica_crimes_frontend/data/services/model/prediction_place_response/text_prediction_api_model.dart';

part 'agressao_api_model.g.dart';

@JsonSerializable()
class AgressaoApiModel {

  AgressaoApiModel({required this.id, required this.qtdAgressores, required this.verbal, required this.ocorrenciaId, required this.fisica});

  final String id;
  final int qtdAgressores;
  final bool verbal;
  final bool fisica;
  final String ocorrenciaId;
  
  Map<String, dynamic> toJson() => _$AgressaoApiModelToJson(this);

  factory AgressaoApiModel.fromJson(Map<String, dynamic> json) => _$AgressaoApiModelFromJson(json);

  
}