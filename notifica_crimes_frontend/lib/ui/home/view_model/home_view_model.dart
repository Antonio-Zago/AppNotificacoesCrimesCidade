import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:notifica_crimes_frontend/data/repositories/map/map_repository.dart';
import 'package:notifica_crimes_frontend/data/repositories/ocorrencias/ocorrencia_repository.dart';
import 'package:notifica_crimes_frontend/domain/models/mapa/ocorrencias/ocorrencia_map.dart';
import 'package:notifica_crimes_frontend/domain/models/place_prediction/place_prediction.dart';
import 'package:uuid/uuid.dart';
import 'package:timezone/timezone.dart' as tz;

class HomeViewModel extends ChangeNotifier {
  HomeViewModel( {
    required this.mapRepository,
    required this.uuid,
    required this.ocorrenciaRepository,
    required this.storage,
  });

  final MapRepository mapRepository;
  final OcorrenciaRepository ocorrenciaRepository;
  final Uuid uuid;
  final FlutterSecureStorage storage;

  bool digitando = false;
  String sessionId = "";
  TextEditingController controllerSearch = TextEditingController();
  List<PlacePrediction> placesPrediction = [];
  final Completer<GoogleMapController> controllerPlace = Completer();
  Exception? error;
  bool carregandoTela = false;
  List<OcorrenciaMap> ocorrencias = [];
  String valorSelecionado = "ano";
  bool estaLogado = false;

  Future<void> initState() async {
    try {
      carregandoTela = true;
      notifyListeners();

      await _defineSeEstaLogado();

      final brasilia = tz.getLocation('America/Sao_Paulo');
      var dataFim = tz.TZDateTime.now(brasilia);

      var dataInicio = tz.TZDateTime(
        brasilia,
        dataFim.year - 1,
        dataFim.month,
        dataFim.day,
        dataFim.hour,
        dataFim.minute,
        dataFim.second,
      );

      var ocorrenciasMap = await ocorrenciaRepository.getAllOcorrencias(
        dataInicio,
        dataFim,
      );

      ocorrencias = ocorrenciasMap.getOrThrow();

      carregandoTela = false;
      notifyListeners();
    } on Exception catch (exception) {
      error = exception;
      carregandoTela = false;
    } finally {
      notifyListeners();
    }
  }

  Future<void> alterarFiltroDataSelecionada(String valor) async {
    try {
      carregandoTela = true;
      valorSelecionado = valor;
      notifyListeners();

      final brasilia = tz.getLocation('America/Sao_Paulo');
      var dataFim = tz.TZDateTime.now(brasilia);

      DateTime? dataInicio;

      if (valor == "ano") {
        dataInicio = tz.TZDateTime(
          brasilia,
          dataFim.year - 1,
          dataFim.month,
          dataFim.day,
          dataFim.hour,
          dataFim.minute,
          dataFim.second,
        );
      } else if (valor == "mes") {
        dataInicio = tz.TZDateTime(
          brasilia,
          dataFim.year,
          dataFim.month - 1,
          dataFim.day,
          dataFim.hour,
          dataFim.minute,
          dataFim.second,
        );
      } else if (valor == "semana") {
        dataInicio = tz.TZDateTime(
          brasilia,
          dataFim.year,
          dataFim.month,
          dataFim.day - 7,
          dataFim.hour,
          dataFim.minute,
          dataFim.second,
        );
      }

      var ocorrenciasMap = await ocorrenciaRepository.getAllOcorrencias(
        dataInicio!,
        dataFim,
      );

      ocorrencias = ocorrenciasMap.getOrThrow();

      carregandoTela = false;

      notifyListeners();
    } on Exception catch (exception) {
      error = exception;
      carregandoTela = false;
    } finally {
      notifyListeners();
    }
  }

  Set<Marker> retornarMarcadoresOcorrencias(BuildContext context) {
    Set<Marker> marcadores = {};

    for (var ocorrencia in ocorrencias) {

      var data =  "${ocorrencia.dataHora.day.toString().padLeft(2, '0')}/${ocorrencia.dataHora.month.toString().padLeft(2, '0')}/${ocorrencia.dataHora.year} ${ocorrencia.dataHora.hour.toString().padLeft(2, '0')}:${ocorrencia.dataHora.minute.toString().padLeft(2, '0')}";

      if (ocorrencia.agressao != null) {
        marcadores.add(
          Marker(
            markerId: MarkerId('marcador_${ocorrencia.id}'),
            position: LatLng(
              ocorrencia.localizacao.latitude,
              ocorrencia.localizacao.longitude,
            ),
            icon: AssetMapBitmap(
              'assets/images/agressao.png',
              width: 25,
              height: 25,
              bitmapScaling: MapBitmapScaling.auto,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text('Agressão'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Data: ${data}'),
                      Text('Descrição: ${ocorrencia.descricao}'),
                      Text('Qtd agressores: ${ocorrencia.agressao!.qtdAgressores}'),
                      Text('Agressão fisica: ${ocorrencia.agressao!.fisica}'),
                      Text('Agressão verbal: ${ocorrencia.agressao!.verbal}'),
                      Text('Id: ${ocorrencia.id}'),
                    ],
                  ),
                  actions: [
                    TextButton(
                      child: Text('Fechar'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      } else if (ocorrencia.assalto != null) {
        marcadores.add(
          Marker(
            markerId: MarkerId('marcador_${ocorrencia.id}'),
            position: LatLng(
              ocorrencia.localizacao.latitude,
              ocorrencia.localizacao.longitude,
            ),
            icon: AssetMapBitmap(
              'assets/images/ocorrencia.png',
              width: 25,
              height: 25,
              bitmapScaling: MapBitmapScaling.auto,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text('Roubo'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Data: ${data}'),
                      Text('Descrição: ${ocorrencia.descricao}'),
                      Text('Qtd agressores: ${ocorrencia.assalto!.qtdAgressores}'),
                      Text('Id: ${ocorrencia.id}'),
                    ],
                  ),
                  actions: [
                    TextButton(
                      child: Text('Fechar'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      } else if (ocorrencia.roubo != null) {
        marcadores.add(
          Marker(
            markerId: MarkerId('marcador_${ocorrencia.id}'),
            position: LatLng(
              ocorrencia.localizacao.latitude,
              ocorrencia.localizacao.longitude,
            ),
            icon: AssetMapBitmap(
              'assets/images/roubo.png',
              width: 25,
              height: 25,
              bitmapScaling: MapBitmapScaling.auto,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text('Furto'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Data: ${data}'),
                      Text('Descrição: ${ocorrencia.descricao}'),
                      Text('Id: ${ocorrencia.id}'),
                    ],
                  ),
                  actions: [
                    TextButton(
                      child: Text('Fechar'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }
    }

    return marcadores;
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

  Future<void> _defineSeEstaLogado() async{

    estaLogado = false;

    final token = await storage.read(key: "token");
    
    if(token != null ){
      if(token.isNotEmpty){
        estaLogado = true;
      }
    }
    
  }
}
