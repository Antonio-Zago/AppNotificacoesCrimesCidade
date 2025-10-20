// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_prediction_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlacePredictionApiModel _$PlacePredictionApiModelFromJson(
  Map<String, dynamic> json,
) => PlacePredictionApiModel(
  place: json['place'] as String,
  text: TextPredictionApiModel.fromJson(json['text'] as Map<String, dynamic>),
  placeId: json['placeId'] as String,
);

Map<String, dynamic> _$PlacePredictionApiModelToJson(
  PlacePredictionApiModel instance,
) => <String, dynamic>{
  'place': instance.place,
  'placeId': instance.placeId,
  'text': instance.text,
};
