import 'package:almas_gemelas_app/features/auth/domain/datasources/auth_datasource.dart';
import 'package:almas_gemelas_app/features/auth/domain/entities/user.dart';

class AuthDatasourceImpl implements AuthDatasource {
  @override
  Future<User> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<User> refreshToken(String refreshToken) {
    // TODO: implement refreshToken
    throw UnimplementedError();
  }

  @override
  Future<User> register(String email, String password) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<void> sendValidationEmail(String email) {
    // TODO: implement sendValidationEmail
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
