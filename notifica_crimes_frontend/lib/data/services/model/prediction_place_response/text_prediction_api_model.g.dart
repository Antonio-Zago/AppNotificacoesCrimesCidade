// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_prediction_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextPredictionApiModel _$TextPredictionApiModelFromJson(
  Map<String, dynamic> json,
) => TextPredictionApiModel(
  text: json['text'] as String,
  matches: (json['matches'] as List<dynamic>)
      .map((e) => MatchesPredictionApiModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$TextPredictionApiModelToJson(
  TextPredictionApiModel instance,
) => <String, dynamic>{'text': instance.text, 'matches': instance.matches};
