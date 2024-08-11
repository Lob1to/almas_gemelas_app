import 'package:almas_gemelas_app/features/auth/domain/datasources/auth_datasource.dart';
import 'package:almas_gemelas_app/features/auth/domain/entities/user.dart';
import 'package:almas_gemelas_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImpl({required this.datasource});

  @override
  Future<User> login(String email, String password) {
    return datasource.login(email, password);
  }

  @override
  Future<User> refreshToken(String refreshToken) {
    return datasource.refreshToken(refreshToken);
  }

  @override
  Future<User> register(String name, String email, String password) {
    return datasource.register(name, email, password);
  }

  @override
  Future<void> sendValidationEmail(String email) {
    return datasource.sendValidationEmail(email);
  }

  @override
  Future<void> signOut(String token) {
    return datasource.signOut(token);
  }
}
