
import 'package:notifica_crimes_frontend/domain/models/login/user.dart';
import 'package:result_dart/result_dart.dart';

abstract class LoginRepository {
  Future<Result<User>> login(String email, String senha); 
  Future<Result<bool>> register(String nome, String email, String senha); 
  Future<Result<bool>> cadastrarCodigoValidacaoEmail();
  Future<Result<bool>> validarCodigoEmail(int codigo);
}