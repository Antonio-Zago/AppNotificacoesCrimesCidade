import 'package:json_annotation/json_annotation.dart';
import 'package:notifica_crimes_frontend/data/services/model/prediction_place_response/text_prediction_api_model.dart';

part 'armas_api_model.g.dart';

@JsonSerializable()
class ArmasApiModel {

  ArmasApiModel(  {required this.id, required this.nome,});

  final String id;
  final String nome;
  
  Map<String, dynamic> toJson() => _$ArmasApiModelToJson(this);

  factory ArmasApiModel.fromJson(Map<String, dynamic> json) => _$ArmasApiModelFromJson(json);
}