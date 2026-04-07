import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/src/presentation/shared/loading_screen.dart';
import 'package:core/lib.dart';
import 'package:resident/presentation/signin/signin_cubit.dart';
import 'package:resident/presentation/signin/signin_state.dart';
import 'package:ui/lib.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<SigninCubit>(
        create: (ctx) => SigninCubit(),
        child: BlocConsumer<SigninCubit, SigninState>(
          listener: (context, state) {
            // if (state is UserSignedInAndApprovedState) {
            //   Go.to(UserHomePage(user: state.user));
            // }
            // if (state is UserSignedInSuccessfullyButNotOnboardedState) {
            //   // Go.to(UserOnboardingFlowPage(userId: state.userId));
            // }
            // if (state is UserSignedInSuccessfullyAndOnboardedState) {
            //   Go.to(UserHomePage(user: state.user));
            // }

            if (state is SigninUserSignedInSuccessfullyState) {
              //Go.to(UserHomePage(user: state.user));
              int k = 0;
            }
          },
          builder: (context, state) {
            if (state is SigninInitialState) {
              return _Signin();
            }

            if (state is SigninUserSigningInState) {
              return LoadingScreen(
                title: 'Resipal',
                subtitle: 'Resident',
                loadingTitle: 'Iniciando sesión',
                loadingDescription: 'Estamos configurando tu espacio...',
              );
            }

            if (state is SigninErrorState) {
              return ErrorView();
            }

            return UnknownStateView();
          },
        ),
      ),
    );
  }
}

class _Signin extends StatelessWidget {
  const _Signin();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SingleChildScrollView(
        child: Column(
          children: [
            GradientCard(
              padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
              borderRadius: 0,
              child: SafeArea(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 0.0),
                  child: Column(
                    children: [
                      ResipalLogo(color: LogoColor.green),
                      const SizedBox(height: 16),
                      HeaderText.giga('Resipal', color: Colors.white),
                      SizedBox(height: 4),
                      HeaderText.two('Resident', color: Colors.white),
                    ],
                  ),
                ),
              ),
            ),
            // --- Login Actions ---
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  HeaderText.four('Bienvenido de nuevo', textAlign: TextAlign.center),
                  const SizedBox(height: 8),
                  Text(
                    'Inicia sesión para gestionar el complejo residencial',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: colorScheme.outline),
                  ),
                  const SizedBox(height: 24),

                  SocialLoginButton(
                    label: 'Continuar con Google',
                    icon: Icons.g_mobiledata_rounded,
                    backgroundColor: Colors.white,
                    textColor: Colors.black87,
                    onPressed: () => context.read<SigninCubit>().signin(SignInProvider.google),
                  ),

                  if (Theme.of(context).platform == TargetPlatform.iOS) ...[
                    const SizedBox(height: 16),
                    SocialLoginButton(
                      label: 'Continuar con Apple',
                      icon: Icons.apple,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      onPressed: () => context.read<SigninCubit>().signin(SignInProvider.apple),
                    ),
                  ],

                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(child: Divider(color: colorScheme.outlineVariant)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text('o continúa con', style: TextStyle(color: colorScheme.outline, fontSize: 12)),
                      ),
                      Expanded(child: Divider(color: colorScheme.outlineVariant)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  EmailSignIn(onSuccess: () => context.read<SigninCubit>().signInWithEmailSuccessfully()),
                  const SizedBox(height: 32),
                  Text(
                    'Al continuar, aceptas nuestros Términos y Condiciones',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10, color: colorScheme.outline),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
