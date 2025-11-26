import 'package:json_annotation/json_annotation.dart';
import 'package:notifica_crimes_frontend/data/services/model/prediction_place_response/text_prediction_api_model.dart';

part 'localizacao_api_model.g.dart';

@JsonSerializable()
class LocalizacaoApiModel {

  LocalizacaoApiModel({required this.id, required this.cep, required this.latitude, required this.longitude, required this.cidade, required this.bairro, required this.rua, required this.numero});

  final String id;
  final String? cep;
  final double latitude;
  final double longitude;
  final String? cidade;
  final String? bairro;
  final String? rua;
  final int? numero;
  
  Map<String, dynamic> toJson() => _$LocalizacaoApiModelToJson(this);

  factory LocalizacaoApiModel.fromJson(Map<String, dynamic> json) => _$LocalizacaoApiModelFromJson(json);

  
}