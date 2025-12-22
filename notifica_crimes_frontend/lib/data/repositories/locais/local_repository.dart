
import 'package:notifica_crimes_frontend/domain/models/local/local.dart';
import 'package:notifica_crimes_frontend/domain/models/login/user.dart';
import 'package:result_dart/result_dart.dart';

abstract class LocalRepository {
  Future<Result<List<Local>>> getLocais();
  Future<Result<Local>> postLocal(String nome, double latitude, double longitude);
  Future<Result<Local>> putLocal(String nome, double latitude, double longitude, String idLocal);
  Future<Result<bool>> deleteLocal(String idLocal);
}