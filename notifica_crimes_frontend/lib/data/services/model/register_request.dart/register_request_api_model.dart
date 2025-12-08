import 'package:json_annotation/json_annotation.dart';

part 'register_request_api_model.g.dart';

@JsonSerializable()
class RegisterRequestApiModel {

  RegisterRequestApiModel({required this.nome, required this.email, required this.senha});

  final String nome;
  final String email;
  final String senha;
  
  Map<String, dynamic> toJson() => _$RegisterRequestApiModelToJson(this);

  factory RegisterRequestApiModel.fromJson(Map<String, dynamic> json) => _$RegisterRequestApiModelFromJson(json);

  
}