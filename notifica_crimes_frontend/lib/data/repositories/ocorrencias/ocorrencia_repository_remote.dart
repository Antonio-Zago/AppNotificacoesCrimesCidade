import 'package:notifica_crimes_frontend/data/repositories/ocorrencias/ocorrencia_repository.dart';
import 'package:notifica_crimes_frontend/data/services/api/api_client.dart';
import 'package:notifica_crimes_frontend/data/services/model/agressao_request/agressao_request_api_model.dart';
import 'package:notifica_crimes_frontend/data/services/model/assalto_request/assalto_request_api_model.dart';
import 'package:notifica_crimes_frontend/data/services/model/ocorrencias_request.dart/localizacao_ocorrencia_request_api_model.dart';
import 'package:notifica_crimes_frontend/data/services/model/ocorrencias_request.dart/ocorrencia_request_api_model.dart';
import 'package:notifica_crimes_frontend/data/services/model/roubo_request/roubo_request_api_model.dart';
import 'package:notifica_crimes_frontend/domain/models/mapa/ocorrencias/agressao_map.dart';
import 'package:notifica_crimes_frontend/domain/models/mapa/ocorrencias/assalto_map.dart';
import 'package:notifica_crimes_frontend/domain/models/mapa/ocorrencias/localizacao_ocorrencia_map.dart';
import 'package:notifica_crimes_frontend/domain/models/mapa/ocorrencias/ocorrencia_map.dart';
import 'package:notifica_crimes_frontend/domain/models/mapa/ocorrencias/roubo_map.dart';
import 'package:notifica_crimes_frontend/domain/models/ocorrencias/agressao.dart';
import 'package:notifica_crimes_frontend/domain/models/ocorrencias/armas.dart';
import 'package:notifica_crimes_frontend/domain/models/ocorrencias/assalto.dart';
import 'package:notifica_crimes_frontend/domain/models/ocorrencias/bens.dart';
import 'package:notifica_crimes_frontend/domain/models/ocorrencias/roubo.dart';
import 'package:result_dart/result_dart.dart';
import 'package:result_dart/src/types.dart';

class OcorrenciaRepositoryRemote implements OcorrenciaRepository {
  OcorrenciaRepositoryRemote({required this.apiClient});

  final ApiClient apiClient;

  @override
  Future<Result<List<Armas>>> findAllArmas() async {
    try {
      List<Armas> listaRetorno = [];

      var response = await apiClient.findAllArmas();

      var armasApi = response.getOrThrow();

      for (var armaApi in armasApi) {
        Armas arma = Armas(id: armaApi.id, nome: armaApi.nome);

        listaRetorno.add(arma);
      }
      return Success(listaRetorno);
    } on Exception catch (exception) {
      return Failure(Exception(exception));
    }
  }

  @override
  Future<Result<List<Bens>>> findAllBens() async {
    try {
      List<Bens> listaRetorno = [];

      var response = await apiClient.findAllBens();

      var bensApi = response.getOrThrow();

      for (var bemApi in bensApi) {
        Bens bem = Bens(id: bemApi.id, nome: bemApi.nome);

        listaRetorno.add(bem);
      }
      return Success(listaRetorno);
    } on Exception catch (exception) {
      return Failure(Exception(exception));
    }
  }

  @override
  Future<Result<void>> postAssalto(Assalto assalto) async {
    try {
      //Aqui vou retirar cep, cidade, etc
      var localizacaoRequest = LocalizacaoOcorrenciaRequestApiModel(
        assalto.ocorrencia.localizacao.cep,
        assalto.ocorrencia.localizacao.cidade,
        assalto.ocorrencia.localizacao.bairro,
        assalto.ocorrencia.localizacao.rua,
        assalto.ocorrencia.localizacao.numero,
        latitude: assalto.ocorrencia.localizacao.latitude,
        longitude: assalto.ocorrencia.localizacao.longitude,
      );

      var ocorrenciaRequest = OcorrenciaRequestApiModel(
        descricao: assalto.ocorrencia.descricao,
        dataHora: assalto.ocorrencia.dataHora,
        localizacao: localizacaoRequest,
      );

      var request = AssaltoRequestApiModel(
        qtdAgressores: assalto.qtdAgressores,
        possuiArma: assalto.possuiArma,
        tentativa: assalto.tentativa,
        tipoArmaId: assalto.tipoArmaId,
        tipoBensId: assalto.tipoBensId,
        ocorrencia: ocorrenciaRequest,
      );

      var retorno = await apiClient.postAssalto(request);

      retorno.getOrThrow();

      return Success(Null);
    } on Exception catch (exception) {
      return Failure(Exception(exception));
    }
  }

  @override
  Future<Result<void>> postRoubo(Roubo roubo) async {
    try {
      //Aqui vou retirar cep, cidade, etc
      var localizacaoRequest = LocalizacaoOcorrenciaRequestApiModel(
        roubo.ocorrencia.localizacao.cep,
        roubo.ocorrencia.localizacao.cidade,
        roubo.ocorrencia.localizacao.bairro,
        roubo.ocorrencia.localizacao.rua,
        roubo.ocorrencia.localizacao.numero,
        latitude: roubo.ocorrencia.localizacao.latitude,
        longitude: roubo.ocorrencia.localizacao.longitude,
      );

      var ocorrenciaRequest = OcorrenciaRequestApiModel(
        descricao: roubo.ocorrencia.descricao,
        dataHora: roubo.ocorrencia.dataHora,
        localizacao: localizacaoRequest,
      );

      var request = RouboRequestApiModel(
        tentativa: roubo.tentativa,
        tipoBensId: roubo.tipoBensId,
        ocorrencia: ocorrenciaRequest,
      );

      var retorno = await apiClient.postRoubo(request);

      retorno.getOrThrow();

      return Success(Null);
    } on Exception catch (exception) {
      return Failure(Exception(exception));
    }
  }

  @override
  Future<Result<void>> postAgressao(Agressao agressao) async {
    try {
      //Aqui vou retirar cep, cidade, etc
      var localizacaoRequest = LocalizacaoOcorrenciaRequestApiModel(
        agressao.ocorrencia.localizacao.cep,
        agressao.ocorrencia.localizacao.cidade,
        agressao.ocorrencia.localizacao.bairro,
        agressao.ocorrencia.localizacao.rua,
        agressao.ocorrencia.localizacao.numero,
        latitude: agressao.ocorrencia.localizacao.latitude,
        longitude: agressao.ocorrencia.localizacao.longitude,
      );

      var ocorrenciaRequest = OcorrenciaRequestApiModel(
        descricao: agressao.ocorrencia.descricao,
        dataHora: agressao.ocorrencia.dataHora,
        localizacao: localizacaoRequest,
      );

      var request = AgressaoRequestApiModel(
        qtdAgressores: agressao.qtdAgressores,
        fisica: agressao.fisica,
        verbal: agressao.verbal,
        ocorrencia: ocorrenciaRequest,
      );

      var retorno = await apiClient.postAgressao(request);

      retorno.getOrThrow();

      return Success(Null);
    } on Exception catch (exception) {
      return Failure(Exception(exception));
    }
  }

  @override
  Future<Result<List<OcorrenciaMap>>> getAllOcorrencias(DateTime dataInicio, DateTime dataFim) async {
    try {
      List<OcorrenciaMap> models = [];

      var retorno = await apiClient.getAllOcorrencias(dataInicio, dataFim);

      var apiModels = retorno.getOrThrow();

      

      for (var apiModel in apiModels) {

        AssaltoMap? assaltoModel;
        AgressaoMap? agressaoModel;
        RouboMap? rouboModel;

        LocalizacaoOcorrenciaMap localizacaoModel = LocalizacaoOcorrenciaMap(
          cep: apiModel.localizacao.cep,
          latitude: apiModel.localizacao.latitude,
          longitude: apiModel.localizacao.longitude,
          cidade: apiModel.localizacao.cidade,
          bairro: apiModel.localizacao.bairro,
          rua: apiModel.localizacao.rua,
          numero: apiModel.localizacao.numero,
        );

        if (apiModel.assalto != null) {
          assaltoModel = AssaltoMap(
            id: apiModel.assalto!.id,
            qtdAgressores: apiModel.assalto!.qtdAgressores,
            possuiArma: apiModel.assalto!.possuiArma,
            ocorrenciaId: apiModel.assalto!.ocorrenciaId,
            tentativa: apiModel.assalto!.tentativa,
            tipoArmaId: apiModel.assalto!.tipoArmaId,
          );
        }

        if (apiModel.agressao != null) {
          agressaoModel = AgressaoMap(
            id: apiModel.agressao!.id,
            qtdAgressores: apiModel.agressao!.qtdAgressores,
            verbal: apiModel.agressao!.verbal,
            fisica: apiModel.agressao!.fisica,
            ocorrenciaId: apiModel.agressao!.ocorrenciaId,
          );
        }

        if (apiModel.roubo != null) {
          rouboModel = RouboMap(
            id: apiModel.roubo!.id,
            tentativa: apiModel.roubo!.tentativa,
            ocorrenciaId: apiModel.roubo!.ocorrenciaId,
          );
        }

        OcorrenciaMap model = OcorrenciaMap(
          id: apiModel.id,
          descricao: apiModel.descricao,
          dataHora: apiModel.dataHora,
          localizacao: localizacaoModel,
          assalto: assaltoModel,
          agressao: agressaoModel,
          roubo: rouboModel,
        );

        models.add(model);
      }

      return Success(models);
    } on Exception catch (exception) {
      return Failure(Exception(exception));
    }
  }
}
