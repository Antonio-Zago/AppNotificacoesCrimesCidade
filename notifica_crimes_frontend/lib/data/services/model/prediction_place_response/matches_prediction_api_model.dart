import 'package:json_annotation/json_annotation.dart';

part 'matches_prediction_api_model.g.dart';

@JsonSerializable()
class MatchesPredictionApiModel {

  MatchesPredictionApiModel({required this.endOffset});
  
  final int endOffset;

  Map<String, dynamic> toJson() => _$MatchesPredictionApiModelToJson(this);

  factory MatchesPredictionApiModel.fromJson(Map<String, dynamic> json) => _$MatchesPredictionApiModelFromJson(json);

}