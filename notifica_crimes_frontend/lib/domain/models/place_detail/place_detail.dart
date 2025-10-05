import 'package:notifica_crimes_frontend/domain/models/place_detail/lat_lng_place_detail.dart';

class PlaceDetail {
  
  PlaceDetail({required this.id, required this.location});

  final String id;
  final LatLngPlaceDetail location;

}