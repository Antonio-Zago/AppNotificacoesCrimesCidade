import 'package:json_annotation/json_annotation.dart';

part 'bens_api_model.g.dart';

@JsonSerializable()
class BensApiModel {

  BensApiModel(  {required this.id, required this.nome,});

  final String id;
  final String nome;
  
  Map<String, dynamic> toJson() => _$BensApiModelToJson(this);

  factory BensApiModel.fromJson(Map<String, dynamic> json) => _$BensApiModelFromJson(json);
}