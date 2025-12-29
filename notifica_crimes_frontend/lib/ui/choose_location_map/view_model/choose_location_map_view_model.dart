import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:notifica_crimes_frontend/data/repositories/map/map_repository.dart';
import 'package:notifica_crimes_frontend/domain/models/place_prediction/place_prediction.dart';
import 'package:uuid/uuid.dart';

class ChooseLocationMapViewModel extends ChangeNotifier {
  ChooseLocationMapViewModel({required this.uuid, required this.mapRepository});

  final MapRepository mapRepository;
  final Uuid uuid;
  
  bool digitando = false;
  String sessionId = "";
  TextEditingController controllerSearch = TextEditingController();
  List<PlacePrediction> placesPrediction = [];
  final Completer<GoogleMapController> controllerPlace = Completer();
  Exception? error;
  Marker? markerLocalSelecionado;
  LatLng? localSelecionado;
  Position? localizacaoAtual;
  bool carregandoTela = true;

  Future<void> initState() async {
    try {
      carregandoTela = true;
      notifyListeners();

      var resultadoLocalizacao = await mapRepository.getLocalizacaoAtual();

      localizacaoAtual = resultadoLocalizacao.getOrThrow();

      carregandoTela = false;
      notifyListeners();
    } on Exception catch (exception) {
      error = exception;
      carregandoTela = false;
    } finally {
      notifyListeners();
    }
  }

  Future<void> onChangedSearch(String text) async {
    try {
      if (text.isNotEmpty) {
        digitando = true;
      } else {
        digitando = false;
      }
      notifyListeners();

      if (sessionId.isEmpty) {
        sessionId = uuid.v4();
      }
      print("------onChangedSearch id= " + sessionId);

      //Aqui substituir pela latitude e longitude atual do usuário
      var resultPlacesPrediction = await mapRepository.requestAutoComplete(
        text,
        -23.22121364638136,
        -45.892987758946624,
        sessionId,
      );

      resultPlacesPrediction.fold(
        (success) {
          placesPrediction = success;
        },
        (failure) {
          error = failure;
        },
      );
    } on Exception catch (exception) {
      error = exception;
    } finally {
      notifyListeners();
    }
  }

  void clearError() {
    error = null;
  }

  Future<void> onTapSearchText() async {
    sessionId = uuid.v4();
    print("------onTapSearchText id= " + sessionId);
  }

  void onTapMap(LatLng latLng) {

    localSelecionado = latLng;

    markerLocalSelecionado = Marker(
                    markerId: MarkerId('marcador'),
                    position: latLng,
                    icon: AssetMapBitmap(
                      'assets/images/marcador.png',
                      width: 25,
                      height: 25,
                      bitmapScaling:MapBitmapScaling.auto,
                    ),
                  );
    notifyListeners();
  }

  Future<void> onTapSearchLocation(String placeId) async {
    try {
      var resultLocation = await mapRepository.placeDetail(placeId, sessionId);

      resultLocation.fold(
        (success) async {
          final controller = await controllerPlace.future;
          controller.animateCamera(
            CameraUpdate.newLatLngZoom(
              LatLng(success.location.latitude, success.location.longitude),
              17,
            ),
          );
        },
        (failure) {
          error = failure;
        },
      );

      _limparControllers();
      sessionId = uuid.v4();
      notifyListeners();
      print("------onTapSearchButton id= " + sessionId);
    } on Exception catch (exception) {
      error = exception;
    } finally {
      notifyListeners();
    }
  }

  void onTapCloseButton() {
    _limparControllers();
    sessionId = uuid.v4();
    notifyListeners();
  }

  _limparControllers() {
    controllerSearch.clear();
    placesPrediction.clear();
  }

  void onPressedSaveButton(BuildContext context){
    if (localSelecionado != null) {
      Navigator.pop(context, localSelecionado); // Retorna o LatLng
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecione um ponto no mapa')),
      );
    }
  }
}
