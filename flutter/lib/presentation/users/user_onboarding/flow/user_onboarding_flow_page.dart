import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resipal/core/ui/views/error_state_view.dart';
import 'package:resipal/core/ui/views/loading_view.dart';
import 'package:resipal/core/ui/views/success_view.dart';
import 'package:resipal/presentation/users/home/user_home_page.dart';
import 'package:resipal/presentation/users/user_onboarding/community_setup/user_onboarding_community_setup_page.dart';
import 'package:resipal/presentation/users/user_onboarding/flow/user_onboarding_flow_state.dart';
import 'package:resipal/presentation/users/user_onboarding/community/join_community/user_onboarding_join_community_page.dart';
import 'package:resipal/presentation/users/user_onboarding/user_data/user_onboarding_user_data_page.dart';
import 'package:resipal/presentation/users/user_onboarding/flow/user_onboarding_flow_cubit.dart';
import 'package:short_navigation/short_navigation.dart';

class UserOnboardingFlowPage extends StatelessWidget {
  final String userId;

  const UserOnboardingFlowPage({required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingFlowCubit()..initialize(userId),
      child: BlocConsumer<OnboardingFlowCubit, UserOnboardingFlowState>(
        listener: (context, state) {
          // if (state == OnboardingStep.completed) {
          //   Go.to(UserHomePage());
          // }
        },
        builder: (context, state) {
          return Scaffold(
            body: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: switch (state) {
                LoadingState() => LoadingView(),
                ErrorState() => ErrorStateView(),
                UserDataState() => UserOnboardingUserDataPage(
                  onUserCreated: (user) => context.read<OnboardingFlowCubit>().onUserCreated(user),
                ),
                CommunityFlowState() => UserOnboardingJoinCommunityPage(
                  communities: state.communities,
                  onCommunityJoined: (community) => context.read<OnboardingFlowCubit>().onCommunityJoined(community),
                ),
                CompletedState() => SuccessView(
                  title: 'Aplicación creada!',
                  subtitle: 'Favor de esperar a que el administrador acepte la solicitud.',
                  actionButtonLabel: 'VOLVER',
                ),

                // TODO: Handle this case.
                UserOnboardingFlowState() => throw UnimplementedError(),
              },
            ),
          );
        },
      ),
    );
  }
}
