import 'package:notifica_crimes_frontend/domain/models/ocorrencias/ocorrencia.dart';

class Assalto {

  final int qtdAgressores;
  final bool possuiArma;
  final bool tentativa;
  final String tipoArmaId;
  final List<String> tipoBensId;
  final Ocorrencia ocorrencia;

  Assalto({required this.qtdAgressores, required this.possuiArma, required this.tentativa, required this.tipoArmaId, required this.tipoBensId, required this.ocorrencia, });
  
 

}