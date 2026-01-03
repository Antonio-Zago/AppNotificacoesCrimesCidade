import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:notifica_crimes_frontend/data/repositories/login/login_repository.dart';

class LoginViewModel extends ChangeNotifier {
  LoginViewModel({required this.loginRepository});

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

      if (formKey.currentState!.validate()) {
        var retorno = await loginRepository.login(
          controllerUsuario.text,
          controllerSenha.text,
        );

        var usuario = retorno.getOrThrow();

        if (usuario.emailValidado) {
          await Navigator.pushNamed(context, "/home");
        }else{

          var codigoExpirado = false;

          codigoExpirado = usuario.expiracaoCodigoValidacaoEmail == null;

          if(usuario.expiracaoCodigoValidacaoEmail != null){
            codigoExpirado = usuario.expiracaoCodigoValidacaoEmail!.isBefore(DateTime.now());
          }

          if(usuario.codigoValidacaoEmail != null && !codigoExpirado){ 
            Navigator.pushNamed(context, "/validacao-email");
          }
          else{
            var retorno = await loginRepository.cadastrarCodigoValidacaoEmail();

            var resultadoCadastroCodigo = retorno.getOrThrow();

            if (!resultadoCadastroCodigo) {
              throw Exception("Erro no cadastro do código de validação");
            }

            Navigator.pushNamed(context, "/validacao-email");
          }
        }

        carregando = false;
      }

      carregando = false;
    } on Exception catch (exception) {
      error = exception;
      carregando = false;
      notifyListeners();
    } finally {
      notifyListeners();
    }
  }

  Future<void> onPressedButtonRegister(BuildContext context) async {
    try {
      carregando = true;
      notifyListeners();

      Navigator.pushNamed(context, "/register");

      carregando = false;
    } finally {
      notifyListeners();
    }
  }

  Future<void> onPressedButtonReturn(BuildContext context) async {
    try {
      carregando = true;
      notifyListeners(); // avisa logo que começou

      Navigator.pushNamed(context, "/");

      carregando = false;
    } finally {
      notifyListeners();
    }
  }

  void clearError() {
    error = null;
  }
}
