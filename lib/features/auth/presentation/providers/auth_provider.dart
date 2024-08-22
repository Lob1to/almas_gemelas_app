import 'package:almas_gemelas_app/features/auth/domain/domain.dart';
import 'package:almas_gemelas_app/features/auth/infrastructure/infrastructure.dart';
import 'package:almas_gemelas_app/features/shared/domain/domain.dart';
import 'package:almas_gemelas_app/features/shared/infrastructure/infrastructure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//! 3. StateNotifierProvider

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();
  final keyValueStorageRepository = KeyValueStorageRepositoryImpl();

  return AuthNotifier(
    authRepository: authRepository,
    keyValueStorageRepository: keyValueStorageRepository,
  );
});

//! 2. AuthNotifier

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  final KeyValueStorageRepository keyValueStorageRepository;

  AuthNotifier({
    required this.keyValueStorageRepository,
    required this.authRepository,
  }) : super(AuthState()) {
    checkAuthStatus();
  }

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

  Future<void> signOut([String? errorMessage]) async {
    await keyValueStorageRepository.removeKey('token');

    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      user: null,
      errorMessage: errorMessage ?? '',
    );
  }

  void checkAuthStatus() async {
    final token =
        await keyValueStorageRepository.getValue<String>('refresh-token');

    if (token == null) return signOut();

    try {
      final user = await authRepository.refreshToken(token);
      _setLoggedUser(user);
    } catch (e) {
      signOut();
    }
  }

  void _setLoggedUser(User user) async {
    await keyValueStorageRepository.setKeyValue(
        'refresh-token', user.refreshToken);
    await keyValueStorageRepository.setKeyValue(
        'access-token', user.accessToken);

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
