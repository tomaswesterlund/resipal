import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin/presentation/signin/signin_cubit.dart';
import 'package:admin/presentation/signin/signin_state.dart';
import 'package:core/lib.dart';
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
            // if (state is AdminSignedInSuccessfullyState) {
            //   Go.to(const AdminHomePage());
            // }
          },
          builder: (context, state) {
            if (state is InitialState) {
              return const _Signin();
            }

            if (state is AdminSigningInState || state is AdminSignedInSuccessfullyState) {
              return LoadingScreen(
                logoColor: LogoColor.blue,
                title: 'Resipal',
                subtitle: 'Admin',
                loadingTitle: 'Iniciando sesión',
                loadingDescription: 'Estamos configurando tu espacio...',
              );
            }

            if (state is ErrorState) {
              return const ErrorView();
            }

            return const UnknownStateView();
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Column(
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
                    ResipalLogo(color: LogoColor.blue),
                    const SizedBox(height: 16),
                    HeaderText.giga('Resipal', color: Colors.white),
                    SizedBox(height: 4),
                    HeaderText.two('Admin', color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
          // --- Login Actions ---
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                HeaderText.four('Bienvenido de nuevo'),
                const SizedBox(height: 8),
                Text(
                  'Inicia sesión para gestionar el complejo residencial',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: colorScheme.outline),
                ),
                const SizedBox(height: 24),

                // Google Sign In
                SocialLoginButton(
                  label: 'Continuar con Google',
                  icon: Icons.g_mobiledata_rounded, // Use a custom SVG for production
                  backgroundColor: Colors.white,
                  textColor: Colors.black87,
                  onPressed: () => context.read<SigninCubit>().signin(SignInProvider.google),
                ),

                const SizedBox(height: 16),

                if (Theme.of(context).platform == TargetPlatform.iOS)
                  SocialLoginButton(
                    label: 'Continuar con Apple',
                    icon: Icons.apple,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    onPressed: () => context.read<SigninCubit>().signin(SignInProvider.apple),
                  ),

                const SizedBox(height: 40),
              ],
            ),
          ),
          const Spacer(),
          SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                'Al continuar, aceptas nuestros Términos y Condiciones',
                style: TextStyle(fontSize: 10, color: colorScheme.outline),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
