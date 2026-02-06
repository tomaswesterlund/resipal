import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resipal/core/ui/app_colors.dart';
import 'package:resipal/core/ui/buttons/cta/primary_cta_button.dart';
import 'package:resipal/core/ui/containers/green_box_container.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/core/ui/views/error_state_view.dart';
import 'package:resipal/core/ui/views/unknown_state_view.dart';
import 'package:resipal/presentation/signin/signin_cubit.dart';
import 'package:resipal/presentation/signin/signin_state.dart';
import 'package:resipal/presentation/users/home/user_home_page.dart';
import 'package:resipal/presentation/users/user_onboarding/user_data/user_onboarding_user_data_page.dart';
import 'package:short_navigation/short_navigation.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SigninCubit>(
      create: (ctx) => SigninCubit(),
      child: BlocConsumer<SigninCubit, SigninState>(
        listener: (context, state) {
          if (state is UserSignedInSuccessfullyState) {
            if (state.userOnboarded) {
              Go.to(UserHomePage(user: state.user!));
            } else {
              Go.to(UserOnboardingUserDataPage());
            }
          }
        },
        builder: (context, state) {
          if (state is InitialState) {
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
                            SvgPicture.asset(
                              'assets/resipal_logo.svg',
                              semanticsLabel: 'Resipal logo',
                            ),
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
                          'Inicia sesión para gestionar tus propiedades',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: AppColors.hintText),
                        ),
                        const SizedBox(height: 40),

                        // Google Sign In
                        _SocialLoginButton(
                          label: 'Continuar con Google',
                          icon: Icons
                              .g_mobiledata_rounded, // Use a custom SVG for production
                          backgroundColor: Colors.white,
                          textColor: Colors.black87,
                          onPressed: () => context.read<SigninCubit>().signin(),
                        ),

                        const SizedBox(height: 16),

                        // Apple Sign In
                        _SocialLoginButton(
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
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.hintText,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is ErrorState) {
            return ErrorStateView(
              errorMessage: state.errorMessage,
              exception: state.exception,
            );
          }

          return UnknownStateView();
        },
      ),
    );
  }
}

class _SocialLoginButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;

  const _SocialLoginButton({
    required this.label,
    required this.icon,
    required this.backgroundColor,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55, // Matching your "Cerrar Sesión" button height
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: textColor, size: 28),
        label: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          side: backgroundColor == Colors.white
              ? BorderSide(color: Colors.grey.shade300)
              : BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: backgroundColor == Colors.white ? 1 : 0,
        ),
      ),
    );
  }
}
