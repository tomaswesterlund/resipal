import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resipal/core/ui/app_colors.dart';
import 'package:resipal/core/ui/buttons/social_login_button.dart';
import 'package:resipal/core/ui/containers/green_box_container.dart';
import 'package:resipal/core/ui/texts/body_text.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/core/ui/views/error_state_view.dart';
import 'package:resipal/core/ui/views/loading_view.dart';
import 'package:resipal/core/ui/views/unknown_state_view.dart';
import 'package:resipal/presentation/signin/signin_cubit.dart';
import 'package:resipal/presentation/signin/signin_state.dart';
import 'package:resipal/presentation/users/home/user_home_page.dart';
import 'package:resipal/presentation/users/user_onboarding/community_setup/user_onboarding_community_setup_page.dart';
import 'package:resipal/presentation/users/user_onboarding/user_data/user_onboarding_user_data_page.dart';
import 'package:resipal/presentation/users/user_onboarding/flow/user_onboarding_flow_page.dart';
import 'package:short_navigation/short_navigation.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SigninCubit>(
      create: (ctx) => SigninCubit()..initialize(),
      child: BlocConsumer<SigninCubit, SigninState>(
        listener: (context, state) {
          if (state is UserAlreadySignedInState) {
            Go.to(UserHomePage(user: state.user));
          }
          if (state is UserSignedInSuccessfullyButNotOnboardedState) {
            Go.to(UserOnboardingFlowPage(userId: state.userId));
          }
          if (state is UserSignedInSuccessfullyAndOnboardedState) {
            Go.to(UserHomePage(user: state.user));
          }
        },
        builder: (context, state) {
          if (state is UserNotSignedInState) {
            return _Signin();
          }

          if (state is InitialState ||
              state is UserSigningInState ||
              state is UserAlreadySignedInState ||
              state is UserSignedInSuccessfullyButNotOnboardedState ||
              state is UserSignedInSuccessfullyAndOnboardedState) {
            return LoadingView(title: 'Iniciando sesión', description: 'Estamos configurando tu espacio...');
          }

          if (state is ErrorState) {
            return ErrorStateView();
          }

          return UnknownStateView();
        },
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
                    SvgPicture.asset('assets/resipal_logo.svg', semanticsLabel: 'Resipal logo'),
                    const SizedBox(height: 16),
                    HeaderText.giga('Resipal', color: Colors.white),
                    const Text(
                      'Bienvenido a tu hogar',
                      style: TextStyle(color: Colors.white70, fontSize: 14, letterSpacing: 0.5),
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
                HeaderText.four('Bienvenido de nuevo', color: AppColors.secondary),
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
