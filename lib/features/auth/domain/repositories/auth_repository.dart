import 'package:almas_gemelas_app/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<User> register(String name, String email, String password);
  Future<User> refreshToken(String refreshToken);
  Future<void> sendValidationEmail(String email);
  Future<void> signOut(String token);
}
