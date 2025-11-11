
import 'package:notifica_crimes_frontend/data/repositories/ocorrencias/ocorrencia_repository.dart';
import 'package:notifica_crimes_frontend/data/services/api/api_client.dart';
import 'package:notifica_crimes_frontend/data/services/model/assalto_request/assalto_request_api_model.dart';
import 'package:notifica_crimes_frontend/data/services/model/ocorrencias_request.dart/localizacao_ocorrencia_request_api_model.dart';
import 'package:notifica_crimes_frontend/data/services/model/ocorrencias_request.dart/ocorrencia_request_api_model.dart';
import 'package:notifica_crimes_frontend/data/services/model/roubo_request/roubo_request_api_model.dart';
import 'package:notifica_crimes_frontend/domain/models/ocorrencias/armas.dart';
import 'package:notifica_crimes_frontend/domain/models/ocorrencias/assalto.dart';
import 'package:notifica_crimes_frontend/domain/models/ocorrencias/bens.dart';
import 'package:notifica_crimes_frontend/domain/models/ocorrencias/roubo.dart';
import 'package:result_dart/result_dart.dart';
import 'package:result_dart/src/types.dart';

class OcorrenciaRepositoryRemote implements OcorrenciaRepository{

  OcorrenciaRepositoryRemote({required this.apiClient});

  final ApiClient apiClient; 

  @override
  Future<Result<List<Armas>>> findAllArmas() async{
    
    try{
      List<Armas> listaRetorno = [];

      var response = await apiClient.findAllArmas();

      var armasApi = response.getOrThrow();


      for(var armaApi in armasApi){
        Armas arma = Armas(id: armaApi.id, nome: armaApi.nome);

        listaRetorno.add(arma);
      }
      return Success(listaRetorno);
    }on Exception catch (exception) {
      return Failure(Exception(exception));
    }   
  }
  
  @override
  Future<Result<List<Bens>>> findAllBens() async{
    
    try{
      List<Bens> listaRetorno = [];

      var response = await apiClient.findAllBens();

      var bensApi = response.getOrThrow();


      for(var bemApi in bensApi){
        Bens bem = Bens(id: bemApi.id, nome: bemApi.nome);

        listaRetorno.add(bem);
      }
      return Success(listaRetorno);
    }on Exception catch (exception) {
      return Failure(Exception(exception));
    } 
  }

  @override
  Future<Result<void>> postAssalto(Assalto assalto) async{
    
    try{

      //Aqui vou retirar cep, cidade, etc
      var localizacaoRequest = LocalizacaoOcorrenciaRequestApiModel(
        assalto.ocorrencia.localizacao.cep, 
        assalto.ocorrencia.localizacao.cidade, 
        assalto.ocorrencia.localizacao.bairro, 
        assalto.ocorrencia.localizacao.rua, 
        assalto.ocorrencia.localizacao.numero, 
        latitude: assalto.ocorrencia.localizacao.latitude, 
        longitude: assalto.ocorrencia.localizacao.longitude
      );

      var ocorrenciaRequest = OcorrenciaRequestApiModel(
        descricao: assalto.ocorrencia.descricao, 
        dataHora: assalto.ocorrencia.dataHora, 
        localizacao: localizacaoRequest
      );

      var request = AssaltoRequestApiModel(
        qtdAgressores: assalto.qtdAgressores, 
        possuiArma: assalto.possuiArma, 
        tentativa: assalto.tentativa, 
        tipoArmaId: assalto.tipoArmaId, 
        tipoBensId: assalto.tipoBensId, 
        ocorrencia: ocorrenciaRequest
      );

      var retorno = await apiClient.postAssalto(request);

      retorno.getOrThrow();

      return Success(Null);
    }on Exception catch (exception) {
      return Failure(Exception(exception));
    } 
  }

  @override
  Future<Result<void>> postRoubo(Roubo roubo) async{ 
    try{

      //Aqui vou retirar cep, cidade, etc
      var localizacaoRequest = LocalizacaoOcorrenciaRequestApiModel(
        roubo.ocorrencia.localizacao.cep, 
        roubo.ocorrencia.localizacao.cidade, 
        roubo.ocorrencia.localizacao.bairro, 
        roubo.ocorrencia.localizacao.rua, 
        roubo.ocorrencia.localizacao.numero, 
        latitude: roubo.ocorrencia.localizacao.latitude, 
        longitude: roubo.ocorrencia.localizacao.longitude
      );

      var ocorrenciaRequest = OcorrenciaRequestApiModel(
        descricao: roubo.ocorrencia.descricao, 
        dataHora: roubo.ocorrencia.dataHora, 
        localizacao: localizacaoRequest
      );

      var request = RouboRequestApiModel(
        tentativa: roubo.tentativa, 
        tipoBensId: roubo.tipoBensId, 
        ocorrencia: ocorrenciaRequest
      );

      var retorno = await apiClient.postRoubo(request);

      retorno.getOrThrow();

      return Success(Null);
    }on Exception catch (exception) {
      return Failure(Exception(exception));
    } 
  }

}