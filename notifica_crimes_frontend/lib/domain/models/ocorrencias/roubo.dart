import 'package:notifica_crimes_frontend/domain/models/ocorrencias/ocorrencia.dart';

class Roubo {

  final bool tentativa;
  final List<String> tipoBensId;
  final Ocorrencia ocorrencia;

  Roubo({required this.tentativa, required this.tipoBensId, required this.ocorrencia, });

}