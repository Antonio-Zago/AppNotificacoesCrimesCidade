import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:notifica_crimes_frontend/data/repositories/login/login_repository.dart';
import 'package:notifica_crimes_frontend/data/services/api/api_client.dart';
import 'package:notifica_crimes_frontend/data/services/model/fcm_request/fcm_request_api_model.dart';
import 'package:notifica_crimes_frontend/data/services/model/login_request/login_request_api_model.dart';
import 'package:notifica_crimes_frontend/data/services/model/register_request.dart/register_request_api_model.dart';
import 'package:notifica_crimes_frontend/data/services/model/validacao_email_request/validacao_email_request_api_model.dart';
import 'package:notifica_crimes_frontend/domain/models/login/user.dart';
import 'package:result_dart/result_dart.dart';

class LoginRepositoryRemote implements LoginRepository{

  LoginRepositoryRemote(  {required this.apiClient,required this.storage, required this.firebaseMessaging,});
  
  final ApiClient apiClient;
  final FlutterSecureStorage storage;
  final FirebaseMessaging firebaseMessaging;

  @override
  Future<Result<User>> login(String email, String senha) async{
    
    try{

      var request = LoginRequestApiModel(email: email, senha: senha);

      var retorno = await apiClient.login(request);

      var loginApiModel = retorno.getOrThrow();

      await storage.write(key: 'token', value: loginApiModel.token);
      await storage.write(key: 'refresh_token', value: loginApiModel.refreshToken);
      await storage.write(key: 'email', value: loginApiModel.email);
      await storage.write(key: 'usuario', value: loginApiModel.usuario);
      await storage.write(key: 'foto', value: loginApiModel.foto);
      await storage.write(key: 'email-validado', value: loginApiModel.emailValidado ? "S" : "N");

      User user = User(token: loginApiModel.token, 
      refreshToken: loginApiModel.refreshToken, 
      expiration: loginApiModel.expiration, 
      nome: loginApiModel.usuario, email: loginApiModel.email,
      foto: loginApiModel.foto, codigoValidacaoEmail: loginApiModel.codigoValidacaoEmail,
      emailValidado: loginApiModel.emailValidado, expiracaoCodigoValidacaoEmail: loginApiModel.expiracaoCodigoValidacaoEmail);

      NotificationSettings permission = await firebaseMessaging
          .requestPermission();

      if (permission.authorizationStatus == AuthorizationStatus.denied) {
        return Success(user);
      }

      final fcm = await firebaseMessaging.getToken();

      await storage.write(key: 'fcm', value: fcm);

      var requestFcm = FcmRequestApiModel(email: email, tokenFcm: fcm!);

      var resultado = await apiClient.postFcm(requestFcm);

      resultado.getOrThrow();

      return Success(user);
    } on Exception catch (exception) {
      return Failure(Exception(exception));
    }
   

  }
  
  @override
  Future<Result<bool>> register(String nome, String email, String senha) async {
    try{

      var request = RegisterRequestApiModel(nome: nome, email: email, senha: senha);

      var retorno = await apiClient.register(request);

      var loginApiModel = retorno.getOrThrow();

      return Success(loginApiModel);
    } on Exception catch (exception) {
      return Failure(Exception(exception));
    }
  }

  @override
  Future<Result<bool>> cadastrarCodigoValidacaoEmail() async {
    try{

      var email = await storage.read(key: 'email');

      var request = ValidacaoEmailRequestApiModel(codigo: null, email: email!);

      var retorno = await apiClient.cadastrarCodigoValidacaoEmail(request);

      var resultado = retorno.getOrThrow();

      return Success(resultado);
    } on Exception catch (exception) {
      return Failure(Exception(exception));
    }
  }

  @override
  Future<Result<bool>> validarCodigoEmail(int codigo) async {
    try{

      var email = await storage.read(key: 'email');

      var request = ValidacaoEmailRequestApiModel(codigo: codigo, email: email!);

      var retorno = await apiClient.validarCodigoEmail(request);

      var resultado = retorno.getOrThrow();

      if(resultado){
        await storage.write(key: 'email-validado', value: "S" );
      }

      return Success(resultado);
    } on Exception catch (exception) {
      return Failure(Exception(exception));
    }
  }

}