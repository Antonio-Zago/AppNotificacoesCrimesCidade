import 'package:flutter/material.dart';
import 'package:notifica_crimes_frontend/data/repositories/locais/local_repository.dart';
import 'package:notifica_crimes_frontend/domain/models/local/local.dart';

class LocaisViewModel extends ChangeNotifier{

  LocaisViewModel({required this.localRepository});

  final LocalRepository localRepository;

  bool carregandoTela = false;
  Exception? error;
  List<Local> locais = [];

  Future<void> initState() async {
    try {
      carregandoTela = true;
      notifyListeners();
      var locaisRetorno = await localRepository.getLocais();

      locais = locaisRetorno.getOrThrow();

      carregandoTela = false;
      notifyListeners();
    } on Exception catch (exception) {
      error = exception;
      carregandoTela = false;
    } finally {
      notifyListeners();
    }
  }

  Future<bool> excluirLocal(String idLocal) async {
    carregandoTela = true;
    notifyListeners();
    try {
      var retornoApi = await localRepository.deleteLocal(idLocal);

      var retorno = retornoApi.getOrThrow();

      carregandoTela = false;
      notifyListeners();

      return retorno;
    } on Exception catch (exception) {
      error = exception;
      carregandoTela = false;
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    error = null;
  }

}