import 'package:almas_gemelas_app/config/config.dart';
import 'package:almas_gemelas_app/features/auth/domain/domain.dart';
import 'package:almas_gemelas_app/features/auth/infrastructure/infrastructure.dart';
import 'package:almas_gemelas_app/features/shared/infrastructure/errors/app_errors.dart';

class AuthDatasourceImpl implements AuthDatasource {
  final http = HttpAdapter(baseUrl: Environment.apiUrl);

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await http.post('/auth/login/', data: {
        'email': email,
        'password': password,
      });

      final user = UserMapper.fromUserJsonToEntity(response.data);

      return user;
    } on AppError catch (e) {
      throw AuthError.fromBackendError(
        {'code': e.code, 'message': e.message},
      );
    } catch (e) {
      throw AppError('¡Ups! Ha sucedido algo inesperado...', 'unknown-error');
    }
  }

  @override
  Future<User> register(String name, String email, String password) async {
    try {
      final response = await http.post('/auth/register/', data: {
        'name': name,
        'email': email,
        'password': password,
      });

      final user = UserMapper.fromUserJsonToEntity(response.data);
      return user;
    } on AppError catch (e) {
      throw AuthError.fromBackendError(
        {'code': e.code, 'message': e.message},
      );
    } catch (e) {
      throw AppError('¡Ups! Ha sucedido algo inesperado...', 'unknown-error');
    }
  }

  @override
  Future<void> sendValidationEmail(String email) async {
    try {
      await http.post('/auth/send-validation', data: {
        'email': email,
      });
    } on AppError catch (e) {
      throw AuthError.fromBackendError(
        {'code': e.code, 'message': e.message},
      );
    } catch (e) {
      throw AppError('¡Ups! Ha sucedido algo inesperado...', 'unknown-error');
    }
  }

  @override
  Future<void> signOut(String token) async {
    try {
      await http.post(
        '/auth/signout/',
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
    } on AppError catch (e) {
      throw AuthError.fromBackendError(
        {'code': e.code, 'message': e.message},
      );
    } catch (e) {
      throw AppError('¡Ups! Ha sucedido algo inesperado...', 'unknown-error');
    }
  }

  @override
  Future<User> refreshToken(String refreshToken) async {
    try {
      final response = await http.post('/auth/refresh-token/', data: {
        'refreshToken': refreshToken,
      });

      final user = UserMapper.fromUserJsonToEntity(response.data);
      return user;
    } on AppError catch (e) {
      throw AuthError.fromBackendError(
        {'code': e.code, 'message': e.message},
      );
    } catch (e) {
      throw AppError('¡Ups! Ha sucedido algo inesperado...', 'unknown-error');
    }
  }
}
