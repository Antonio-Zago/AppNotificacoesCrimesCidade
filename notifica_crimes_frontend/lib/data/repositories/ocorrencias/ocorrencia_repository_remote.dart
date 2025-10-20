
import 'package:notifica_crimes_frontend/data/repositories/ocorrencias/ocorrencia_repository.dart';
import 'package:notifica_crimes_frontend/data/services/api/api_client.dart';
import 'package:notifica_crimes_frontend/domain/models/ocorrencias/armas.dart';
import 'package:notifica_crimes_frontend/domain/models/ocorrencias/bens.dart';
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
  Future<Result<List<Bens>>> findAllBens() {
    // TODO: implement findAllBens
    throw UnimplementedError();
  }

}