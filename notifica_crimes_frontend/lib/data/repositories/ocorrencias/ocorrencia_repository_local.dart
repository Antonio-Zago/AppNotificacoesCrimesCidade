import 'package:notifica_crimes_frontend/data/repositories/ocorrencias/ocorrencia_repository.dart';
import 'package:notifica_crimes_frontend/data/services/local/local_data_service.dart';
import 'package:notifica_crimes_frontend/domain/models/ocorrencias/armas.dart';
import 'package:notifica_crimes_frontend/domain/models/ocorrencias/assalto.dart';
import 'package:notifica_crimes_frontend/domain/models/ocorrencias/bens.dart';
import 'package:notifica_crimes_frontend/domain/models/ocorrencias/roubo.dart';
import 'package:result_dart/result_dart.dart';

class OcorrenciaRepositoryLocal implements OcorrenciaRepository{

  OcorrenciaRepositoryLocal({required this.localDataService});

  final LocalDataService localDataService;

  @override
  Future<Result<List<Armas>>> findAllArmas() async{
    
    try{
      List<Armas> listaRetorno = [];

      var response = await localDataService.findAllArmas();

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

      var response = await localDataService.findAllBens();

      var bensApi = response.getOrThrow();


      for(var bemApi in bensApi){
        Bens arma = Bens(id: bemApi.id, nome: bemApi.nome);

        listaRetorno.add(arma);
      }
      return Success(listaRetorno);
    }on Exception catch (exception) {
      return Failure(Exception(exception));
    } 
  }

  @override
  Future<Result<void>> postAssalto(Assalto assalto) {
    // TODO: implement postAssalto
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> postRoubo(Roubo roubo) {
    // TODO: implement postRoubo
    throw UnimplementedError();
  }

}