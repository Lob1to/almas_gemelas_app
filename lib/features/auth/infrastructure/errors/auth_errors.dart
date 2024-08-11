import '../../../shared/infrastructure/errors/app_errors.dart';

class AuthError extends AppError {
  AuthError(String message, String code) : super(message, code);

  factory AuthError.fromBackendError(Map<String, dynamic> error) {
    final code = error['code'] as String;
    final message = error['message'] as String;

    switch (code) {
      case 'missing-email':
        return AuthError('Por favor, ingresa tu correo electrónico', code);
      case 'invalid-email':
        return AuthError(
            'El correo electrónico no parece ser válido. ¿Podrías revisarlo?',
            code);
      case 'missing-password':
        return AuthError('No olvides ingresar tu contraseña', code);
      case 'short-password':
        return AuthError(
            'Tu contraseña es un poco corta. ¿Podrías hacerla más larga?',
            code);
      case 'long-password':
        return AuthError(
            'Tu contraseña es demasiado larga. ¿Podrías acortarla un poco?',
            code);
      case 'missing-name':
        return AuthError('Por favor, dinos tu nombre', code);
      case 'invalid-password':
        return AuthError(
            'Tu contraseña debe incluir al menos una mayúscula, una minúscula y un número',
            code);
      case 'incorrect-password':
        return AuthError(
            'La contraseña no es correcta. ¿Quieres intentarlo de nuevo?',
            code);
      case 'email-already-in-use':
        return AuthError(
            'Este correo ya está registrado. ¿Quieres iniciar sesión?', code);
      case 'user-not-found':
        return AuthError(
            'No encontramos tu cuenta. ¿Quieres crear una nueva?', code);
      case 'invalid-credentials':
        return AuthError(
            'El correo o la contraseña no son correctos. ¿Quieres intentarlo de nuevo?',
            code);
      default:
        return AuthError(message, code);
    }
  }
}
