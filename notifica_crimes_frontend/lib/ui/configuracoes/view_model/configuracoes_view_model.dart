import 'package:flutter/material.dart';
import 'package:notifica_crimes_frontend/data/repositories/configuracoes/configuracoes_repository.dart';
import 'package:notifica_crimes_frontend/domain/models/configuracoes/configuracao.dart';
import 'package:notifica_crimes_frontend/domain/models/ocorrencias/armas.dart';

class ConfiguracoesViewModel extends ChangeNotifier{

  ConfiguracoesViewModel({required this.configuracoesRepository});

  final ConfiguracoesRepository configuracoesRepository;

  bool carregandoTela = false;
  final formKey = GlobalKey<FormState>();
  String? notificaLocal;
  String? notificaLocalizacao;
  TextEditingController notificaLocalDistanciaController = TextEditingController();
  TextEditingController notificaLocalizacaoDistanciaController = TextEditingController();
  Exception? error;
  Configuracao? configuracao;

  Future<void> initState() async {
    try {
      carregandoTela = true;
      notifyListeners();
      var configuracaoApi = await configuracoesRepository.findConfiguracoes();

      configuracao = configuracaoApi.getOrThrow();

      if(configuracao != null){
        notificaLocal = configuracao!.notificaLocal;
        notificaLocalizacao = configuracao!.notificaLocalizacao;
        notificaLocalDistanciaController.text = configuracao!.distanciaLocal.toString();
        notificaLocalizacaoDistanciaController.text = configuracao!.distanciaLocalizacao.toString();
      }
      
      carregandoTela = false;
      notifyListeners();
    } on Exception catch (exception) {
      error = exception;
      carregandoTela = false;
    } finally {
      notifyListeners();
    }
  }

  void clearError() {
    error = null;
  }

  void onChangedButtonNotificaLocal(String? valor) {

    notificaLocal = valor;

    notifyListeners();
  }

  void onChangedButtonNotificaLocalizacao(String? valor) {

    notificaLocalizacao = valor;

    notifyListeners();
  }

  Future<bool> saveConfiguracoes() async {
    carregandoTela = true;
    notifyListeners();
    try {
      if (formKey.currentState!.validate()) {
        
        var distanciaLocal = 0.0;
        if(notificaLocalDistanciaController.text.isNotEmpty){
          distanciaLocal = double.parse(notificaLocalDistanciaController.text);
        }

        var distanciaLocalizacao = 0.0;
        if(notificaLocalizacaoDistanciaController.text.isNotEmpty){
          distanciaLocalizacao = double.parse(notificaLocalizacaoDistanciaController.text);
        }

        await configuracoesRepository.putConfiguracoes(notificaLocal == "S", notificaLocalizacao == "S", distanciaLocal, distanciaLocalizacao);

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