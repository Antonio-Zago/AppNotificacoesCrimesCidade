import 'package:json_annotation/json_annotation.dart';

part 'error_default_api_model.g.dart';

@JsonSerializable()
class ErrorDefaultApiModel {

  ErrorDefaultApiModel(  {required this.message,});

  final String message;
  
  Map<String, dynamic> toJson() => _$ErrorDefaultApiModelToJson(this);

  factory ErrorDefaultApiModel.fromJson(Map<String, dynamic> json) => _$ErrorDefaultApiModelFromJson(json);
}