import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:notifica_crimes_frontend/data/repositories/locais/local_repository.dart';

class RegisterLocalViewModel extends ChangeNotifier{

  RegisterLocalViewModel({required this.localRepository});

  final LocalRepository localRepository;

  bool carregandoTela = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController nomeController = TextEditingController();
  double? latitude;
  double? longitude;
  TextEditingController localizacaoController = TextEditingController();
  Exception? error;

  Future<void> onTapButtonChoseLocation(BuildContext context) async {
    final retornoLocalizacaoSelecionada = await Navigator.pushNamed(
      context,
      '/choose-location-map',
    );

    if (retornoLocalizacaoSelecionada is LatLng?) {
      if (retornoLocalizacaoSelecionada != null) {
        localizacaoController.text =
            "Latitude: ${retornoLocalizacaoSelecionada.latitude} - Longitude: ${retornoLocalizacaoSelecionada.longitude} ";
        latitude = retornoLocalizacaoSelecionada.latitude;
        longitude = retornoLocalizacaoSelecionada.longitude;
        notifyListeners();
      }
    }
  }
  
  void clearError() {
    error = null;
  }

  Future<bool> saveLocal() async {
    carregandoTela = true;
    notifyListeners();
    try {
      if (formKey.currentState!.validate()) {

        var retorno = await localRepository.postLocal(nomeController.text,latitude!, longitude!);

        retorno.getOrThrow();

        carregandoTela = false;
        notifyListeners();

        return true;
      }

      carregandoTela = false;
      notifyListeners();
      return false;
    } on Exception catch (exception) {
      error = exception;
      carregandoTela = false;
      notifyListeners();
      return false;
    }
  }

}