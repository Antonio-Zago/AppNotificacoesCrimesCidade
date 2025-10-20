import 'package:json_annotation/json_annotation.dart';
import 'package:notifica_crimes_frontend/data/services/model/prediction_place_response/matches_prediction_api_model.dart';

part 'text_prediction_api_model.g.dart';

@JsonSerializable()
class TextPredictionApiModel {

  TextPredictionApiModel({required this.text, required this.matches,});

  final String text;
  final List<MatchesPredictionApiModel> matches;
  
  Map<String, dynamic> toJson() => _$TextPredictionApiModelToJson(this);

  factory TextPredictionApiModel.fromJson(Map<String, dynamic> json) => _$TextPredictionApiModelFromJson(json);
}