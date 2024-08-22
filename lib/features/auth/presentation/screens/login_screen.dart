import 'package:almas_gemelas_app/features/auth/presentation/providers/login_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:almas_gemelas_app/features/shared/presentation/widgets/widgets.dart';
import 'package:almas_gemelas_app/features/auth/presentation/providers/auth_forms_provider.dart';
import 'package:go_router/go_router.dart';

import '../providers/auth_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final logoSize = (size.width > 1000) ? size.width * 0.12 : 130.0;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          body: GeometricalBackground(
              child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 50),

            // Logo de la empresa
            Row(children: [
              // Se ubica el logo exactamente en la mitad del eje horizontal
              SizedBox(width: (size.width * 0.5) - logoSize / 2),

              Image.asset('public/images/logo.png', height: logoSize),
            ]),
            const SizedBox(height: 10),

            // Container para el formulario de login
            Container(
              // (10 de un SizedBox y 50 del otro SizedBox)
              height: null,
              width: size.width,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(130))),
              child: const _LoginForm(),
            ),
          ],
        ),
      ))),
    );
  }
}

class _LoginForm extends ConsumerWidget {
  const _LoginForm();

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPasswordVisible = ref.watch(isLoginPasswordVisibleProvider);
    final checkboxValue = ref.watch(checkboxValueProvider);

    final loginForm = ref.watch(loginFormProvider);

    ref.listen(authProvider, (previous, next) {
      if (next.errorMessage.isEmpty) return;

      showSnackBar(context, next.errorMessage);
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          const SizedBox(height: 80),
          const Text(
            'Para continuar entra a tu cuenta',
            style: TextStyle(
                fontFamily: 'Satoshi',
                fontWeight: FontWeight.w700,
                fontSize: 22),
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            formTitle: 'Correo',
            hint: 'Correo electrónico',
            keyboardType: TextInputType.emailAddress,
            onChanged: ref.read(loginFormProvider.notifier).onEmailChanged,
            errorMessage:
                loginForm.isFormPosted ? loginForm.email.errorMessage : null,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            formTitle: 'Contraseña',
            hint: '••••••••••••',
            obscureText: isPasswordVisible,
            showVisibilityButton: true,
            passwordVisibilityCallback: () {
              ref
                  .read(isLoginPasswordVisibleProvider.notifier)
                  .update((state) => !state);
            },
            onChanged: ref.read(loginFormProvider.notifier).onPasswordChanged,
            errorMessage:
                loginForm.isFormPosted ? loginForm.password.errorMessage : null,
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              CustomCheckbox(
                size: 30,
                color: const Color(0xffF1B2B9),
                value: checkboxValue,
                onChanged: (_) {
                  ref
                      .read(checkboxValueProvider.notifier)
                      .update((state) => !state);
                },
              ),
              const SizedBox(width: 15),
              const Text(
                'Recuérdame',
                style: TextStyle(
                  fontFamily: 'Satoshi',
                  fontSize: 16,
                  color: Color(0xff181E22),
                ),
              )
            ],
          ),
          const SizedBox(height: 30),
          CustomFilledButton(
              text: 'ENTRAR',
              buttonColor: const Color(0xffF1B2B9),
              onPressed: loginForm.isPosting
                  ? null
                  : () => ref.read(loginFormProvider.notifier).onFormSubmit()),
          const SizedBox(height: 30),
          SizedBox(
              width: double.infinity,
              child: PushableText(
                text: '¿Olvidaste tu contraseña?',
                textAlign: TextAlign.center,
                onPressed: () {
                  // TODO: Redireccionar a la pagina de olvidar contraseña
                },
              )),
          const SizedBox(height: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '¿No tienes una cuenta? ',
                style: TextStyle(fontSize: 17, color: Color(0xff181E22)),
              ),
              PushableText(
                text: 'Registrate',
                onPressed: () {
                  context.go('/register');
                },
              )
            ],
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
