import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal/core/services/auth_service.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/domain/entities/community_entity.dart';
import 'package:resipal/domain/use_cases/create_community_application.dart';
import 'package:resipal/domain/use_cases/fetch_communities.dart';
import 'package:resipal/domain/use_cases/fetch_user.dart';
import 'package:resipal/domain/use_cases/get_communities.dart';
import 'package:resipal/domain/use_cases/get_user.dart';
import 'package:resipal/presentation/users/user_onboarding/community/join_community/user_onboarding_join_community_state.dart';

class UserOnboardingJoinCommunityCubit extends Cubit<UserOnboardingJoinCommunityState> {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final AuthService _authService = GetIt.I<AuthService>();

  UserOnboardingJoinCommunityCubit() : super(InitialState());

  Future initialize() async {
    try {
      emit(LoadingState());
      await FetchCommunities().call();
      final communities = GetCommunities().call();
      emit(LoadedState(communities));
    } catch (e, s) {
      _logger.logException(exception: e, featureArea: 'UserOnboardingJoinCommunityCubit.initialize', stackTrace: s);
      emit(ErrorState());
    }
  }

  Future onCommunitySelected(CommunityEntity community) async {
    try {
      emit(LoadingState());

      final userId = _authService.getSignedInUserId();
      await CreateCommunityApplication().call(communityId: community.id, userId: userId);
      await FetchUser().call(userId);
      // Fetch communities?
      // Fetch applications?
      final user = GetUser().call(userId);

      emit(JoinedCommunitySuccessfully(community: community, user: user));
    } catch (e, s) {
      _logger.logException(
        exception: e,
        featureArea: 'UserOnboardingJoinCommunityCubit.onCommunityJoined',
        stackTrace: s,
        metadata: {'community': community},
      );

      emit(ErrorState());
    }
  }
}
