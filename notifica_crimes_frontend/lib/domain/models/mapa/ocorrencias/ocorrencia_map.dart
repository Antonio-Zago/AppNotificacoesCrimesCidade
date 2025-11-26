import 'package:notifica_crimes_frontend/domain/models/mapa/ocorrencias/agressao_map.dart';
import 'package:notifica_crimes_frontend/domain/models/mapa/ocorrencias/assalto_map.dart';
import 'package:notifica_crimes_frontend/domain/models/mapa/ocorrencias/localizacao_ocorrencia_map.dart';
import 'package:notifica_crimes_frontend/domain/models/mapa/ocorrencias/roubo_map.dart';

class OcorrenciaMap {

  final String id;
  final String descricao;
  final DateTime dataHora;
  final LocalizacaoOcorrenciaMap localizacao;
  final AssaltoMap? assalto;
  final AgressaoMap? agressao;
  final RouboMap? roubo;

  OcorrenciaMap({required this.id, required this.descricao, required this.dataHora, required this.localizacao, required this.assalto, required this.agressao, required this.roubo});
  
}