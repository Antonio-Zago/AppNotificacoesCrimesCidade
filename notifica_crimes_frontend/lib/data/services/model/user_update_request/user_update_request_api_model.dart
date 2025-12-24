
import 'package:json_annotation/json_annotation.dart';

part 'user_update_request_api_model.g.dart';

@JsonSerializable()
class UserUpdateRequestApiModel {

  UserUpdateRequestApiModel( {required this.email,required this.nome,required this.foto,} );

  final String email;
  final String nome;
  final String? foto;
  
  Map<String, dynamic> toJson() => _$UserUpdateRequestApiModelToJson(this);

  factory UserUpdateRequestApiModel.fromJson(Map<String, dynamic> json) => _$UserUpdateRequestApiModelFromJson(json);
}