
import 'package:notifica_crimes_frontend/domain/models/login/user.dart';
import 'package:result_dart/result_dart.dart';

abstract class LoginRepository {
  Future<Result<User>> login(String email, String senha); 
}