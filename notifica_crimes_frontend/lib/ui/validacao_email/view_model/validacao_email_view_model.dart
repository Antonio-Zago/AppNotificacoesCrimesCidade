import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notifica_crimes_frontend/data/repositories/login/login_repository.dart';

class ValidacaoEmailViewModel extends ChangeNotifier {
  ValidacaoEmailViewModel({required this.loginRepository});

  final LoginRepository loginRepository;

  final formKey = GlobalKey<FormState>();
  final TextEditingController controllerCodigo = TextEditingController();
  bool carregando = false;
  Exception? error;
  int _tempoTotal = 120; 
  int _tempoRestante = 0;
  Timer? _timer;

  bool get botaoDesabilitado => _tempoRestante > 0;
 

  void clearError() {
    error = null;
  }

  Future<bool> onPressedButtonValidar() async {
    try {
      carregando = true;
      notifyListeners();

      if (formKey.currentState!.validate()) {
        var retorno = await loginRepository.validarCodigoEmail(
          int.parse(controllerCodigo.text),
        );

        var validou = retorno.getOrThrow();

        if (!validou) {
          throw Exception("Erro na validação do código");
        }

        carregando = false;

        return validou;
      }

      carregando = false;
      return false;
    } on Exception catch (exception) {
      error = exception;
      carregando = false;
      notifyListeners();
      return false;
    } finally {
      notifyListeners();
    }
  }

   Future<bool> onPressedButtonReenviar() async {
    try {
      carregando = true;
      notifyListeners();

      var retorno = await loginRepository.cadastrarCodigoValidacaoEmail();

      var resultadoCadastroCodigo = retorno.getOrThrow();

      if (!resultadoCadastroCodigo) {
        throw Exception("Erro no cadastro do código de validação");
      }

      carregando = false;
      return true;
    } on Exception catch (exception) {
      error = exception;
      carregando = false;
      notifyListeners();
      return false;
    } finally {
      notifyListeners();
    }
  }

  Future<void> onPressedButtonReturnLogin(BuildContext context) async {
    try {
      carregando = true;
      notifyListeners(); // avisa logo que começou

      Navigator.pushNamed(context, "/login");

      carregando = false;
    } finally {
      notifyListeners();
    }
  }

  Future<void> onPressedButtonReturnRegister(BuildContext context) async {
    try {
      carregando = true;
      notifyListeners(); // avisa logo que começou

      Navigator.pushNamed(context, "/");

      carregando = false;
    } finally {
      notifyListeners();
    }
  }

   void iniciarTimer() {
      _tempoRestante = _tempoTotal;
      notifyListeners();

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_tempoRestante <= 1) {
        timer.cancel();
          _tempoRestante = 0;
          notifyListeners();
      } else {
          _tempoRestante--;
          notifyListeners();
      }
    });
  }

  String formatarTempo() {
    final minutos = (_tempoRestante ~/ 60).toString().padLeft(2, '0');
    final segundos = (_tempoRestante % 60).toString().padLeft(2, '0');
    return '$minutos:$segundos';
  }
}
