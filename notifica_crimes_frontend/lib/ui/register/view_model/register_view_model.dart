import 'package:flutter/material.dart';
import 'package:notifica_crimes_frontend/data/repositories/login/login_repository.dart';

class RegisterViewModel extends ChangeNotifier{

  RegisterViewModel({required this.loginRepository});

  final LoginRepository loginRepository;
  final TextEditingController controllerUsuario = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerSenha = TextEditingController();
  final TextEditingController controllerRepitaSenha = TextEditingController();
  Exception? error;
  final formKey = GlobalKey<FormState>();

  bool carregando = false;

  Future<bool> onPressedButtonRegister() async{
    try {
      carregando = true;
      notifyListeners(); 

      if (formKey.currentState!.validate()){
        var retorno = await loginRepository.register(controllerUsuario.text, controllerEmail.text, controllerSenha.text);

        var foiSalvo = retorno.getOrThrow();

        carregando = false;

        return foiSalvo;
      }

      carregando = false;
      return false;
    } on Exception catch (exception) {
      error = exception;
      carregando = false;
      notifyListeners();
      return false;
    }  
    finally {
      notifyListeners();
    }
  }

  Future<void> onPressedButtonReturn(BuildContext context) async {
    try {
      carregando = true;
      notifyListeners(); // avisa logo que começou

      Navigator.pushNamed(
        context,
        "/login"
      );

      carregando = false;
    } finally {
      notifyListeners();
    }
  }

  Future<void> onPressedButtonReturnHome(BuildContext context) async {
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