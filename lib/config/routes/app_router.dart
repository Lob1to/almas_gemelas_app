import 'package:almas_gemelas_app/config/routes/app_router_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/auth/presentation/screens/screens.dart';
import '../../features/home/presentation/screens/screens.dart';

final appRouterProvider = Provider<GoRouter>(
  (ref) {
    final goRouterNotifier = ref.read(goRouterNotifierProvider);

    return GoRouter(
        initialLocation: '/splash',
        refreshListenable: goRouterNotifier,
        routes: [
          ///* Home Screens
          GoRoute(
            path: '/',
            builder: (context, state) => const HomeScreen(),
          ),

          ///* Auth Screens
          GoRoute(
            path: '/splash',
            builder: (context, state) => const CheckAuthStatusScreen(),
          ),

          GoRoute(
            path: '/login',
            builder: (context, state) => const LoginScreen(),
          ),

          GoRoute(
            path: '/register',
            builder: (context, state) => const RegisterScreen(),
          ),
        ],
        redirect: (context, state) {
          final isGoingTo = state.fullPath;
          final authStatus = goRouterNotifier.authStatus;

          if (isGoingTo == '/splash' && authStatus == AuthStatus.checking) {
            return null;
          }

          if (authStatus == AuthStatus.notAuthenticated) {
            if (isGoingTo == '/login' || isGoingTo == '/register') return null;

            return '/login';
          }

          if (authStatus == AuthStatus.authenticated) {
            if (isGoingTo == '/login' ||
                isGoingTo == '/register' ||
                isGoingTo == '/splash') {
              return '/';
            }
          }

          return null;
        });
  },
);
