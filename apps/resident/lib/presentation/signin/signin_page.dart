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
                loadingDescription: 'Estamos configurando tu espacio...'
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
    return Scaffold(
      backgroundColor: context.colors.scheme.surface,
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
                    ResipalLogo(),
                    const SizedBox(height: 16),
                    HeaderText.giga('Resipal', color: Colors.white),
                    SizedBox(height: 4,),
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
              children: [
                HeaderText.four('Bienvenido de nuevo'),
                const SizedBox(height: 8),
                Text(
                  'Inicia sesión para gestionar tus propiedades o tu comunidad',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: context.colors.scheme.outline),
                ),
                const SizedBox(height: 24),

                // Google Sign In
                SocialLoginButton(
                  label: 'Continuar con Google',
                  icon: Icons.g_mobiledata_rounded, // Use a custom SVG for production
                  backgroundColor: Colors.white,
                  textColor: Colors.black87,
                  onPressed: () => context.read<SigninCubit>().signin(),
                ),

                const SizedBox(height: 16),

                // Apple Sign In
                SocialLoginButton(
                  label: 'Continuar con Apple',
                  icon: Icons.apple,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  onPressed: () {
                    // TODO: Implement Apple Sign In
                  },
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
                style: TextStyle(fontSize: 10, color: context.colors.scheme.outline),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
