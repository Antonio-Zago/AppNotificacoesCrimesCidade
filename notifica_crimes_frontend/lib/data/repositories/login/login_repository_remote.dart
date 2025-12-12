import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:notifica_crimes_frontend/data/repositories/login/login_repository.dart';
import 'package:notifica_crimes_frontend/data/services/api/api_client.dart';
import 'package:notifica_crimes_frontend/data/services/model/fcm_request/fcm_request_api_model.dart';
import 'package:notifica_crimes_frontend/data/services/model/login_request/login_request_api_model.dart';
import 'package:notifica_crimes_frontend/data/services/model/register_request.dart/register_request_api_model.dart';
import 'package:notifica_crimes_frontend/domain/models/login/user.dart';
import 'package:result_dart/result_dart.dart';

class LoginRepositoryRemote implements LoginRepository{

  LoginRepositoryRemote( {required this.apiClient,required this.storage,});
  
  final ApiClient apiClient;
  final FlutterSecureStorage storage;

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

      var fcmToken = await storage.read(key: 'fcm');

      var requestFcm = FcmRequestApiModel(email: email, tokenFcm: fcmToken!);

      var resultado = await apiClient.postFcm(requestFcm);

      resultado.getOrThrow();

      User user = User(token: loginApiModel.token, 
      refreshToken: loginApiModel.refreshToken, 
      expiration: loginApiModel.expiration, 
      nome: loginApiModel.usuario, email: loginApiModel.email);

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

}