import 'package:json_annotation/json_annotation.dart';

part 'fcm_request_api_model.g.dart';

@JsonSerializable()
class FcmRequestApiModel {

  FcmRequestApiModel({required this.email, required this.tokenFcm});

  final String email;
  final String tokenFcm;
  
  Map<String, dynamic> toJson() => _$FcmRequestApiModelToJson(this);

  factory FcmRequestApiModel.fromJson(Map<String, dynamic> json) => _$FcmRequestApiModelFromJson(json);

  
}