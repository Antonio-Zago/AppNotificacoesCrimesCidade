import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:notifica_crimes_frontend/data/repositories/locais/local_repository.dart';
import 'package:notifica_crimes_frontend/data/repositories/login/login_repository.dart';
import 'package:notifica_crimes_frontend/data/services/api/api_client.dart';
import 'package:notifica_crimes_frontend/data/services/model/fcm_request/fcm_request_api_model.dart';
import 'package:notifica_crimes_frontend/data/services/model/local_request/local_request_api_model.dart';
import 'package:notifica_crimes_frontend/data/services/model/login_request/login_request_api_model.dart';
import 'package:notifica_crimes_frontend/data/services/model/register_request.dart/register_request_api_model.dart';
import 'package:notifica_crimes_frontend/domain/models/local/local.dart';
import 'package:notifica_crimes_frontend/domain/models/login/user.dart';
import 'package:result_dart/result_dart.dart';

class LocalRepositoryRemote implements LocalRepository{

  LocalRepositoryRemote( {required this.apiClient,required this.storage,});
  
  final ApiClient apiClient;
  final FlutterSecureStorage storage;

  @override
  Future<Result<List<Local>>> getLocais() async{
    
    try{
      
      List<Local> locaisRetorno = [];

      var email = await storage.read(key: "email");

      var locais = await apiClient.getLocais(email!);

      var locaisApiModel = locais.getOrThrow();

      for(var localRetorno in locaisApiModel){

        var local = Local(id: localRetorno.id, nome: localRetorno.nome, latitude: localRetorno.latitude, longitude: localRetorno.longitude); 

        locaisRetorno.add(local);
      }

      return Success(locaisRetorno);
    } on Exception catch (exception) {
      return Failure(Exception(exception));
    }
   

  }
  
  @override
  Future<Result<bool>> deleteLocal(String idLocal) async{
    try{

      var retornoApi = await apiClient.deleteLocal(idLocal);

      var retorno = retornoApi.getOrThrow();

      return Success(retorno);
    } on Exception catch (exception) {
      return Failure(Exception(exception));
    }
  }
  
  @override
  Future<Result<Local>> postLocal(String nome, double latitude, double longitude) async{
    try{
      
      var email = await storage.read(key: "email");

      var request = LocalRequestApiModel(nome: nome, latitude: latitude, longitude: longitude, email: email!);

      var localResponse = await apiClient.postLocal(request);

      var localApiModel = localResponse.getOrThrow();

      var local = Local(id: localApiModel.id, nome: localApiModel.nome, latitude: localApiModel.latitude, longitude: localApiModel.longitude);

      return Success(local);
    } on Exception catch (exception) {
      return Failure(Exception(exception));
    }
  }
  
  @override
  Future<Result<Local>> putLocal(String nome, double latitude, double longitude, String idLocal) async {
    
    try{
      
      var email = await storage.read(key: "email");

      var request = LocalRequestApiModel(nome: nome, latitude: latitude, longitude: longitude, email: email!);

      var localResponse = await apiClient.putLocal(request, idLocal);

      var localApiModel = localResponse.getOrThrow();

      var local = Local(id: localApiModel.id, nome: localApiModel.nome, latitude: localApiModel.latitude, longitude: localApiModel.longitude);

      return Success(local);
    } on Exception catch (exception) {
      return Failure(Exception(exception));
    }
  }

}