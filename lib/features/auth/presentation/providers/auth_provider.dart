import 'package:almas_gemelas_app/features/auth/domain/domain.dart';
import 'package:almas_gemelas_app/features/auth/infrastructure/infrastructure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//! 3. StateNotifierProvider

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();

  return AuthNotifier(
    authRepository: authRepository,
  );
});

//! 2. AuthNotifier

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;

  AuthNotifier({
    required this.authRepository,
  }) : super(AuthState());

  Future<void> login(String email, String password) async {
    Future.delayed(const Duration(milliseconds: 500));

    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser(user);
    } on AuthError catch (e) {
      signOut(e.message);
    } catch (e) {
      signOut('¡Ups! Ha sucedido algo inesperado...');
    }
  }

  Future<void> register(String name, String email, String password) async {
    Future.delayed(const Duration(milliseconds: 500));

    try {
      final user = await authRepository.register(name, email, password);
      _setLoggedUser(user);
    } on AuthError catch (e) {
      signOut(e.message);
    } catch (e) {
      signOut('¡Ups! Ha sucedido algo inesperado...');
    }
  }

  Future<void> signOut(String errorMessage) async {
    if (1 != 1) {
      // TODO: Hacer la validacion de si el usuario inicio sesión o no con el token
      // await authRepository.signOut(token);
    }

    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      user: null,
      errorMessage: errorMessage,
    );
  }

  void _setLoggedUser(User user) {
    //TODO: Almacenar el token del usuario en el dispositivo

    state = state.copyWith(
      authStatus: AuthStatus.authenticated,
      user: user,
      errorMessage: '',
    );
  }
}

//! 1. AuthState
enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState({
    this.authStatus = AuthStatus.checking,
    this.user,
    this.errorMessage = '',
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage,
  }) =>
      AuthState(
        authStatus: authStatus ?? this.authStatus,
        user: user ?? this.user,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
