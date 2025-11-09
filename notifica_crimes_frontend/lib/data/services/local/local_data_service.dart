import 'package:notifica_crimes_frontend/data/services/model/ocorrencias_reponse/armas_api_model.dart';
import 'package:notifica_crimes_frontend/data/services/model/ocorrencias_reponse/bens_api_model.dart';
import 'package:result_dart/result_dart.dart';

class LocalDataService {

  Future<Result<List<ArmasApiModel>>> findAllArmas() async {
    try{
      List<ArmasApiModel> retorno = [];


      var arma1 = ArmasApiModel(id: "1", nome: 'Faca');
      retorno.add(arma1);
      var arma2 = ArmasApiModel(id: "2", nome: 'Arma');
      retorno.add(arma2);
      var arma3 = ArmasApiModel(id: "3", nome: 'Martelo');
      retorno.add(arma3);

      return Success(retorno);
    }on Exception catch(exception){
      return Failure(Exception(exception));
    } 
  }

  Future<Result<List<BensApiModel>>> findAllBens() async {
    try{
      List<BensApiModel> retorno = [];

      var bem = BensApiModel(id: "1", nome: 'Eletrônicos');
      retorno.add(bem);

      var bem2 = BensApiModel(id: "2", nome: 'Automóvel');
      retorno.add(bem2);

      var bem3 = BensApiModel(id: "3", nome: 'Joias');
      retorno.add(bem3);


      return Success(retorno);
    }on Exception catch(exception){
      return Failure(Exception(exception));
    } 
  }
}