// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_detail_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceDetailApiModel _$PlaceDetailApiModelFromJson(Map<String, dynamic> json) =>
    PlaceDetailApiModel(
      id: json['id'] as String,
      location: LatLngApiModel.fromJson(
        json['location'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$PlaceDetailApiModelToJson(
  PlaceDetailApiModel instance,
) => <String, dynamic>{'id': instance.id, 'location': instance.location};
