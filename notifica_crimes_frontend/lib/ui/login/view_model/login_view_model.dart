import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  bool carregando = false;

  Future<void> onPressedButtonLogin(BuildContext context) async {
    try {
      carregando = true;
      notifyListeners(); // avisa logo que começou

      // espera 5 segundos
      // Aqui vai a lógica de login
      await Future.delayed(const Duration(seconds: 5));

      await Navigator.pushNamed(
        context,
        "/home"
      );

      carregando = false;
    } finally {
      notifyListeners();
    }
  }

  Future<void> onPressedButtonRegister(BuildContext context) async {
    try {
      carregando = true;
      notifyListeners(); // avisa logo que começou

      Navigator.pushNamed(
        context,
        "/register"
      );

      carregando = false;
    } finally {
      notifyListeners();
    }
  }
}
