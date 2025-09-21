import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier{
  
  
  bool carregando = false;

  Future<void> onPressedButtonLogin() async{
    try {
      carregando = true;
      notifyListeners(); // avisa logo que começou

       // espera 5 segundos
       // Aqui vai a lógica de login
      await Future.delayed(const Duration(seconds: 5));

      carregando = false;
    } finally {
      notifyListeners();
    }
  }

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
}