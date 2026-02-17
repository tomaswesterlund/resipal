import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resipal_admin/presentation/auth/auth_cubit.dart';
import 'package:resipal_admin/presentation/auth/auth_state.dart';
import 'package:resipal_admin/presentation/home/admin_home_page.dart';
import 'package:resipal_admin/presentation/signin/signin_page.dart';
import 'package:resipal_core/presentation/shared/texts/header_text.dart';
import 'package:resipal_core/presentation/shared/views/error_view.dart';
import 'package:resipal_core/presentation/shared/views/loading_view.dart';
import 'package:resipal_core/presentation/shared/views/unknown_state_view.dart';
import 'package:short_navigation/short_navigation.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<AuthCubit>(
        create: (ctx) => AuthCubit()..initialize(),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (ctx, state) {
            if (state is UserSignedIn) {
              Go.to(AdminHomePage());
            }

            if (state is UserNotSignedIn) {
              Go.to(SigninPage());
            }
          },
          builder: (ctx, state) {
            if (state is InitialState || state is LoadingState || state is UserSignedIn || state is UserNotSignedIn) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HeaderText.giga('RESIPAL'),
                  const SizedBox(height: 24),
                  LoadingView(title: 'Iniciando Panel de Control', description: 'Verificando credenciales de administrador...'),
                ],
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
