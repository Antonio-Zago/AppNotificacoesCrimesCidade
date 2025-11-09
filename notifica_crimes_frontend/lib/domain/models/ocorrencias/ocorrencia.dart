import 'package:notifica_crimes_frontend/domain/models/ocorrencias/localizacao_ocorrencia.dart';

class Ocorrencia {

  final String descricao;
  final DateTime dataHora;
  final LocalizacaoOcorrencia localizacao;

  Ocorrencia({required this.descricao, required this.dataHora, required this.localizacao, });
  
}