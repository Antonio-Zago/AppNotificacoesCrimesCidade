import 'package:flutter/material.dart';

class RegisterViewModel extends ChangeNotifier{
  bool carregando = false;

  Future<void> onPressedButtonRegister() async{
    try {
      carregando = true;
      notifyListeners(); // avisa logo que começou

       // espera 5 segundos
       // Aqui vai a lógica de cadastro
      await Future.delayed(const Duration(seconds: 5));

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