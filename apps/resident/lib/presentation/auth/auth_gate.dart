import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resipal_core/lib.dart';
import 'package:resident/presentation/auth/auth_gate_cubit.dart';
import 'package:resident/presentation/auth/auth_gate_state.dart';
import 'package:resident/presentation/signin/signin_page.dart';
import 'package:wester_kit/lib.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthGateCubit>(
      // Initialize immediately to check session
      create: (ctx) => AuthGateCubit()..initialize(),
      child: BlocBuilder<AuthGateCubit, AuthGateState>(
        builder: (ctx, state) {
          // 1. Loading / Initialization States
          if (state is AuthGateInitialState || state is AuthGateLoadingState) {
            return LoadingScreen(
              title: 'Resipal',
              subtitle: 'Resident',
              loadingTitle: 'Iniciando sesión',
              loadingDescription: 'Estamos configurando tu espacio...',
            );
          }

          // 2. Unauthenticated -> Go to Sign In
          if (state is AuthGateUserNotSignedIn) {
            return const SigninPage();
          }

          // 3. Authenticated but No Profile -> Go to Onboarding
          if (state is AuthGateUserNotOnboarded) {
            return ResidentOnboardingPage(application: state.application);
          }

          // 4. Profile exists but No Community -> Go to Community Registration
          if (state is AuthGateUserHasNoResidentMembership) {
            return ResidentApplicationsPage(user: state.user);
          }

          // 5. Success -> The Main Admin Dashboard
          if (state is UserSignedIn) {
            final community = GetCommunityById().call(state.resident.community.id);
            return ResidentHomePage(community: community, resident: state.resident);
          }

          if (state is AuthGateErrorState) return const ErrorView();

          return const UnknownStateView();
        },
      ),
    );
  }
}
