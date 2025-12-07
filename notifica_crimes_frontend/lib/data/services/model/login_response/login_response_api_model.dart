import 'package:json_annotation/json_annotation.dart';

part 'login_response_api_model.g.dart';

@JsonSerializable()
class LoginResponseApiModel {

  LoginResponseApiModel( {required this.token, required this.refreshToken,required this.expiration,required this.usuario,required this.email,});

  final String token;
  final String refreshToken;
  final DateTime expiration;
  final String usuario;
  final String email;
  
  Map<String, dynamic> toJson() => _$LoginResponseApiModelToJson(this);

  factory LoginResponseApiModel.fromJson(Map<String, dynamic> json) => _$LoginResponseApiModelFromJson(json);

  
}