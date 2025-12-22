
import 'package:json_annotation/json_annotation.dart';

part 'local_request_api_model.g.dart';

@JsonSerializable()
class LocalRequestApiModel {

  LocalRequestApiModel( {required this.nome, required this.latitude,required this.longitude, required this.email});

  final String nome;
  final double latitude;
  final double longitude;
  final String email;
  
  Map<String, dynamic> toJson() => _$LocalRequestApiModelToJson(this);

  factory LocalRequestApiModel.fromJson(Map<String, dynamic> json) => _$LocalRequestApiModelFromJson(json);

  
}