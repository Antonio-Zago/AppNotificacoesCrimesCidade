
import 'package:json_annotation/json_annotation.dart';
import 'package:notifica_crimes_frontend/data/services/model/ocorrencias_request.dart/ocorrencia_request_api_model.dart';

part 'roubo_request_api_model.g.dart';

@JsonSerializable()
class RouboRequestApiModel {

  RouboRequestApiModel({required this.tentativa,required this.tipoBensId, required this.ocorrencia   });

  final bool tentativa;
  final List<String> tipoBensId;
  final OcorrenciaRequestApiModel ocorrencia;
  
  Map<String, dynamic> toJson() => _$RouboRequestApiModelToJson(this);

  factory RouboRequestApiModel.fromJson(Map<String, dynamic> json) => _$RouboRequestApiModelFromJson(json);
}