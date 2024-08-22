import 'package:almas_gemelas_app/features/auth/presentation/providers/register_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:almas_gemelas_app/features/shared/presentation/widgets/widgets.dart';
import 'package:almas_gemelas_app/features/auth/presentation/providers/auth_forms_provider.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
              child: const _RegisterForm(),
            ),
          ],
        ),
      ))),
    );
  }
}

class _RegisterForm extends ConsumerWidget {
  const _RegisterForm();

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPasswordVisible = ref.watch(isRegisterPasswordVisibleProvider);
    final isConfirmPasswordVisible =
        ref.watch(isRegisterConfirmPasswordVisibleProvider);
    final registerForm = ref.watch(registerFormProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          const SizedBox(height: 80),
          const Text(
            'Para continuar crea tu cuenta',
            style: TextStyle(
                fontFamily: 'Satoshi',
                fontWeight: FontWeight.w700,
                fontSize: 22),
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            formTitle: 'Nombre',
            hint: 'Nombre completo',
            keyboardType: TextInputType.name,
            onChanged:
                ref.read(registerFormProvider.notifier).onFullNameChanged,
            errorMessage: registerForm.isFormPosted
                ? null
                : registerForm.fullName.errorMessage,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            formTitle: 'Correo',
            hint: 'Correo electrónico',
            keyboardType: TextInputType.emailAddress,
            onChanged: ref.read(registerFormProvider.notifier).onEmailChanged,
            errorMessage: registerForm.isFormPosted
                ? registerForm.email.errorMessage
                : null,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            formTitle: 'Contraseña',
            hint: '••••••••••••',
            obscureText: isPasswordVisible,
            showVisibilityButton: true,
            passwordVisibilityCallback: () {
              ref
                  .read(isRegisterPasswordVisibleProvider.notifier)
                  .update((state) => !state);
            },
            onChanged:
                ref.read(registerFormProvider.notifier).onPasswordChanged,
            errorMessage: registerForm.isFormPosted
                ? registerForm.password.errorMessage
                : null,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            formTitle: 'Confimar contraseña',
            hint: '••••••••••••',
            obscureText: isConfirmPasswordVisible,
            showVisibilityButton: true,
            passwordVisibilityCallback: () {
              ref
                  .read(isRegisterConfirmPasswordVisibleProvider.notifier)
                  .update((state) => !state);
            },
            onChanged:
                ref.read(registerFormProvider.notifier).onRepeatPasswordChanged,
            errorMessage: registerForm.isFormPosted
                ? registerForm.repeatPassword.errorMessage
                : null,
          ),
          const SizedBox(height: 30),
          CustomFilledButton(
            text: 'CONTINUAR',
            buttonColor: const Color(0xffF1B2B9),
            onPressed: (registerForm.isPosting)
                ? null
                : ref.read(registerFormProvider.notifier).onFormSumbit,
          ),
          const SizedBox(height: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '¿Ya tienes una cuenta? ',
                style: TextStyle(fontSize: 17, color: Color(0xff181E22)),
              ),
              PushableText(
                text: 'Entrar',
                onPressed: () {
                  context.go('/login');
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
