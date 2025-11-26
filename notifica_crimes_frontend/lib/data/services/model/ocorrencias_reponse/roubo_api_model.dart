import 'package:json_annotation/json_annotation.dart';
import 'package:notifica_crimes_frontend/data/services/model/prediction_place_response/text_prediction_api_model.dart';

part 'roubo_api_model.g.dart';

@JsonSerializable()
class RouboApiModel {

  RouboApiModel({required this.id, required this.tentativa, required this.ocorrenciaId});

  final String id;
  final bool tentativa;
  final String ocorrenciaId;
  
  Map<String, dynamic> toJson() => _$RouboApiModelToJson(this);

  factory RouboApiModel.fromJson(Map<String, dynamic> json) => _$RouboApiModelFromJson(json);

  
}