import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resipal_resident/presentation/auth/auth_cubit.dart';
import 'package:resipal_resident/presentation/auth/auth_state.dart';
import 'package:resipal_resident/presentation/signin/signin_page.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:wester_kit/lib.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<AuthCubit>(
        create: (ctx) => AuthCubit()..initialize(),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (ctx, state) {
            if (state is AuthUserSignedIn) {
              Go.to(ResidentHomePage(resident: state.resident));
            }

            if (state is AuthUserNotSignedIn) {
              Go.to(SigninPage());
            }
          },
          builder: (ctx, state) {
            if (state is AuthInitialState ||
                state is AuthLoadingState ||
                state is AuthUserSignedIn ||
                state is AuthUserNotSignedIn) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HeaderText.giga('RESIPAL'),
                  const SizedBox(height: 24),
                  LoadingView(
                    title: 'Preparando tu hogar',
                    description: 'Estamos verificando tu acceso a la comunidad...',
                  ),
                ],
              );
            }

            if (state is AuthErrorState) {
              return ErrorView();
            }

            return UnknownStateView();
          },
        ),
      ),
    );
  }
}
