import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:notifica_crimes_frontend/data/repositories/login/login_repository.dart';

class LoginViewModel extends ChangeNotifier {

  LoginViewModel( {required this.loginRepository,});

  final LoginRepository loginRepository;

  bool carregando = false;
  TextEditingController controllerUsuario = TextEditingController();
  TextEditingController controllerSenha = TextEditingController();
  Exception? error;
  final formKey = GlobalKey<FormState>();

  Future<void> onPressedButtonLogin(BuildContext context) async {
    try {
      carregando = true;
      notifyListeners(); 

      if (formKey.currentState!.validate()){
        var retorno = await loginRepository.login(controllerUsuario.text, controllerSenha.text);

        var usuario = retorno.getOrThrow();

        await Navigator.pushNamed(
          context,
          "/"
        );
        carregando = false;
      }

      carregando = false;
    }on Exception catch (exception) {
      error = exception;
      carregando = false;
      notifyListeners();
    }    
    finally {
      notifyListeners();
    }
  }

  Future<void> onPressedButtonRegister(BuildContext context) async {
    try {
      carregando = true;
      notifyListeners(); 

      Navigator.pushNamed(
        context,
        "/register"
      );

      carregando = false;
    } finally {
      notifyListeners();
    }
  }

  Future<void> onPressedButtonReturn(BuildContext context) async {
    try {
      carregando = true;
      notifyListeners(); // avisa logo que começou

      Navigator.pushNamed(
        context,
        "/"
      );

      carregando = false;
    } finally {
      notifyListeners();
    }
  }

  void clearError() {
    error = null;
  }
}
