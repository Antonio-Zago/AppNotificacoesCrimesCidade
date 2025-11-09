
import 'package:notifica_crimes_frontend/domain/models/ocorrencias/armas.dart';
import 'package:notifica_crimes_frontend/domain/models/ocorrencias/assalto.dart';
import 'package:notifica_crimes_frontend/domain/models/ocorrencias/bens.dart';
import 'package:result_dart/result_dart.dart';

abstract class OcorrenciaRepository {
  Future<Result<List<Armas>>> findAllArmas();
  Future<Result<List<Bens>>> findAllBens();
  Future<Result<void>> postAssalto(Assalto assalto);
}