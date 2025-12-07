import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:notifica_crimes_frontend/data/repositories/login/login_repository.dart';

class LoginViewModel extends ChangeNotifier {

  LoginViewModel( {required this.loginRepository,});

  final LoginRepository loginRepository;

  bool carregando = false;
  TextEditingController controllerUsuario = TextEditingController();
  TextEditingController controllerSenha = TextEditingController();

  Future<void> onPressedButtonLogin(BuildContext context) async {
    try {
      carregando = true;
      notifyListeners(); 

      var usuario = await loginRepository.login(controllerUsuario.text, controllerSenha.text);

      await Navigator.pushNamed(
        context,
        "/"
      );

      carregando = false;
    } finally {
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
}
