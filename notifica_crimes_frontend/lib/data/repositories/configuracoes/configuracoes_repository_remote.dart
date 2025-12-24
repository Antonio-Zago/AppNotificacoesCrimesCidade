import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:notifica_crimes_frontend/data/repositories/configuracoes/configuracoes_repository.dart';
import 'package:notifica_crimes_frontend/data/services/api/api_client.dart';
import 'package:notifica_crimes_frontend/data/services/model/configuracoes_request/configuracoes_request_api_model.dart';
import 'package:notifica_crimes_frontend/data/services/model/ocorrencias_request.dart/ocorrencia_request_api_model.dart';
import 'package:notifica_crimes_frontend/data/services/model/user_update_request/user_update_request_api_model.dart';
import 'package:notifica_crimes_frontend/domain/models/configuracoes/configuracao.dart';
import 'package:notifica_crimes_frontend/domain/models/ocorrencias/roubo.dart';
import 'package:result_dart/result_dart.dart';

class ConfiguracoesRepositoryRemote implements ConfiguracoesRepository {

  ConfiguracoesRepositoryRemote( {required this.storage, required this.apiClient,});

  final FlutterSecureStorage storage;  
  final ApiClient apiClient;

  @override
  Future<Result<Configuracao>> findConfiguracoes() async {
    try {
      
      var email = await storage.read(key: 'email');

      var response = await apiClient.findConfiguracoes(email!);

      var configuracaoApi = response.getOrThrow();

      var configuracao = Configuracao(
        notificaLocalizacao: configuracaoApi.notificaLocalizacao ? "S" : "N", 
        notificaLocal: configuracaoApi.notificaLocal ? "S" : "N", 
        distanciaLocalizacao: configuracaoApi.distanciaLocalizacao, 
        distanciaLocal: configuracaoApi.distanciaLocal
      );

      return Success(configuracao);
    } on Exception catch (exception) {
      return Failure(Exception(exception));
    }
  }

  @override
  Future<Result<bool>> putConfiguracoes(bool notificaLocal, bool notificaLocalizacao, double distanciaLocal, double distanciaLocalizacao) async {
    try {

      var email = await storage.read(key: 'email');
      //Aqui vou retirar cep, cidade, etc
      var localizacaoRequest = ConfiguracoesRequestApiModel(
        email: email!,
        distanciaLocal: distanciaLocal,
        distanciaLocalizacao: distanciaLocalizacao,
        notificaLocal: notificaLocal,
        notificaLocalizacao: notificaLocalizacao
      );

      var retorno = await apiClient.putConfiguracao(localizacaoRequest);

      retorno.getOrThrow();

      return Success(true);
    } on Exception catch (exception) {
      return Failure(Exception(exception));
    }
  }

  @override
  Future<Result<bool>> putPerfil(String nomeUsuario, String? fotoBase64) async {
    try {

      var email = await storage.read(key: 'email');
      //Aqui vou retirar cep, cidade, etc
      var request = UserUpdateRequestApiModel(
        email: email!,
        nome: nomeUsuario,
        foto: fotoBase64
      );

      var retorno = await apiClient.putUser(request);

      retorno.getOrThrow();

      return Success(true);
    } on Exception catch (exception) {
      return Failure(Exception(exception));
    }
  }


}