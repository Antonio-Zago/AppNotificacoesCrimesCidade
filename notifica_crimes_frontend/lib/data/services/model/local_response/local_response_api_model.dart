
import 'package:json_annotation/json_annotation.dart';

part 'local_response_api_model.g.dart';

@JsonSerializable()
class LocalResponseApiModel {

  LocalResponseApiModel( {required this.id, required this.nome, required this.latitude,required this.longitude,});

  final String id;
  final String nome;
  final double latitude;
  final double longitude;
  
  Map<String, dynamic> toJson() => _$LocalResponseApiModelToJson(this);

  factory LocalResponseApiModel.fromJson(Map<String, dynamic> json) => _$LocalResponseApiModelFromJson(json);

  
}