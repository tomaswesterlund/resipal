import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal/core/services/auth_service.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/domain/entities/community_entity.dart';
import 'package:resipal/domain/entities/user_entity.dart';
import 'package:resipal/domain/use_cases/fetch_communities.dart';
import 'package:resipal/domain/use_cases/get_communities.dart';
import 'package:resipal/domain/use_cases/user_exists.dart';
import 'package:resipal/domain/use_cases/user_has_joined_any_community.dart';
import 'package:resipal/presentation/users/user_onboarding/flow/user_onboarding_flow_state.dart';

enum OnboardingStep { loading, error, userData, communitySetup, completed }

class OnboardingFlowCubit extends Cubit<UserOnboardingFlowState> {
  final AuthService _authService = GetIt.I<AuthService>();
  final LoggerService _logger = GetIt.I<LoggerService>();

  OnboardingFlowCubit() : super(LoadingState());

  Future initialize(String userId) async {
    try {
      emit(LoadingState());
      final userExists = await UserExists().call(userId);

      if (userExists == false) {
        emit(UserDataState());
        return;
      }

      final hasJoinedAnyCommunity = UserHasJoinedAnyCommunity().call(userId);
      if (hasJoinedAnyCommunity == false) {
        await FetchCommunities().call();
        final communities = GetCommunities().call();
        emit(CommunityFlowState(communities));
        return;
      }

      throw UnimplementedError('User exists and has joined a community. Unhandles state.');
    } catch (e, s) {
      _logger.logException(
        exception: e,
        featureArea: 'OnboardingFlowCubit.initialize',
        stackTrace: s,
        metadata: {'userId': userId},
      );
      emit(ErrorState());
    }
  }

  Future onUserCreated(UserEntity user) async {
    await FetchCommunities().call();
    final communities = GetCommunities().call();
    emit(CommunityFlowState(communities));
  }

  Future onCommunityJoined(CommunityEntity community) async {
    //await ServiceLocator.initializeCommunityScope(community.id);
    emit(CompletedState());
  }
}
