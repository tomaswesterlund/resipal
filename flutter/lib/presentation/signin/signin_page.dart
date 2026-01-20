import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resipal/core/ui/buttons/cta/primary_cta_button.dart';
import 'package:resipal/core/ui/views/error_state_view.dart';
import 'package:resipal/core/ui/views/unknown_state_view.dart';
import 'package:resipal/presentation/signin/signin_cubit.dart';
import 'package:resipal/presentation/users/home/user_home_page.dart';
import 'package:short_navigation/short_navigation.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SigninCubit>(
      create: (ctx) => SigninCubit(),
      child: BlocConsumer<SigninCubit, SigninState>(
        listener: (context, state) {
          if(state is UserSignedInSuccessfullyState) {
            Go.to(UserHomePage(user: state.user));
          }
        },
        builder: (context, state) {
          if (state is InitialState) {
            return Scaffold(
              body: Center(
                child: PrimaryCtaButton(
                  label: 'SIGNIN',
                  canSubmit: true,
                  onPressed: () => context.read<SigninCubit>().signin(),
                ),
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
