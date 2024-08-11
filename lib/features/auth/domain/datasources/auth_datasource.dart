import 'package:almas_gemelas_app/features/auth/domain/entities/user.dart';

abstract class AuthDatasource {
  Future<User> login(String email, String password);
  Future<User> register(String email, String password);
  Future<User> refreshToken(String refreshToken);
  Future<void> sendValidationEmail(String email);
  Future<void> signOut();
}
