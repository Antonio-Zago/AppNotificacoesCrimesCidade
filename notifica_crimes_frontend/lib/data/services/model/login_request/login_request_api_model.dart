import 'package:json_annotation/json_annotation.dart';

part 'login_request_api_model.g.dart';

@JsonSerializable()
class LoginRequestApiModel {

  LoginRequestApiModel({required this.email, required this.senha});

  final String email;
  final String senha;
  
  Map<String, dynamic> toJson() => _$LoginRequestApiModelToJson(this);

  factory LoginRequestApiModel.fromJson(Map<String, dynamic> json) => _$LoginRequestApiModelFromJson(json);

  
}