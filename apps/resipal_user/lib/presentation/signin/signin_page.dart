import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resipal_core/presentation/shared/buttons/social_login_button.dart';
import 'package:resipal_core/presentation/shared/colors/app_colors.dart';
import 'package:resipal_core/presentation/shared/containers/green_box_container.dart';
import 'package:resipal_core/presentation/shared/resipal_logo.dart';
import 'package:resipal_core/presentation/shared/texts/header_text.dart';
import 'package:resipal_core/presentation/shared/views/error_view.dart';
import 'package:resipal_core/presentation/shared/views/loading_view.dart';
import 'package:resipal_core/presentation/shared/views/unknown_state_view.dart';
import 'package:resipal_user/presentation/signin/signin_cubit.dart';
import 'package:resipal_user/presentation/signin/signin_state.dart';
import 'package:resipal_user/presentation/home/user_home_page.dart';
import 'package:short_navigation/short_navigation.dart';

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

            if (state is UserSignedInSuccessfullyState) {
              //Go.to(UserHomePage(user: state.user));
              int k = 0;
            }
          },
          builder: (context, state) {
            if (state is InitialState) {
              return _Signin();
            }

            if (state is UserSigningInState) {
              return LoadingView(
                title: 'Iniciando sesión',
                description: 'Estamos configurando tu espacio...',
              );
            }

            if (state is ErrorState) {
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
  const _Signin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // --- Brand Header ---
          GreenBoxContainer(
            child: SafeArea(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 0.0),
                child: Column(
                  children: [
                    ResipalLogo(),
                    const SizedBox(height: 16),
                    HeaderText.giga('Resipal', color: Colors.white),
                    const Text(
                      'Bienvenido a tu hogar',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        letterSpacing: 0.5,
                      ),
                    ),
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
                HeaderText.four(
                  'Bienvenido de nuevo',
                  color: AppColors.secondary,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Inicia sesión para gestionar tus propiedades o tu comunidad',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.hintText),
                ),
                const SizedBox(height: 24),

                // Google Sign In
                SocialLoginButton(
                  label: 'Continuar con Google',
                  icon: Icons
                      .g_mobiledata_rounded, // Use a custom SVG for production
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
          const SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                'Al continuar, aceptas nuestros Términos y Condiciones',
                style: TextStyle(fontSize: 10, color: AppColors.hintText),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
