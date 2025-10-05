import 'package:json_annotation/json_annotation.dart';
import 'package:notifica_crimes_frontend/data/services/api/model/prediction_place_response/text_prediction_api_model.dart';

part 'place_prediction_api_model.g.dart';

@JsonSerializable()
class PlacePredictionApiModel {

  PlacePredictionApiModel( {required this.place, required this.text, required this.placeId, });

  final String place;
  final String placeId;
  final TextPredictionApiModel text;
  
  Map<String, dynamic> toJson() => _$PlacePredictionApiModelToJson(this);

  factory PlacePredictionApiModel.fromJson(Map<String, dynamic> json) => _$PlacePredictionApiModelFromJson(json);
}