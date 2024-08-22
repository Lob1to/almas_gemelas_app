import 'package:almas_gemelas_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:almas_gemelas_app/features/shared/presentation/widgets/pushable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: PushableText(
          text: 'Cerrar sesión',
          onPressed: () {
            ref.read(authProvider.notifier).signOut();
          },
        ),
      ),
    );
  }
}
