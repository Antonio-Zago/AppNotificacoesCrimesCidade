
import 'package:notifica_crimes_frontend/domain/models/configuracoes/configuracao.dart';
import 'package:result_dart/result_dart.dart';

abstract class ConfiguracoesRepository {
  Future<Result<bool>> putConfiguracoes(bool notificaLocal, bool notificaLocalizacao, double distanciaLocal, double distanciaLocalizacao);
  Future<Result<Configuracao>> findConfiguracoes();
  Future<Result<bool>> putPerfil(String nomeUsuario, String? fotoBase64);
}