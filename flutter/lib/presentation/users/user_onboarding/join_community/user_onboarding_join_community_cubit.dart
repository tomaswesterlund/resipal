import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal/core/services/auth_service.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/domain/entities/community_entity.dart';
import 'package:resipal/domain/use_cases/fetch_communities.dart';
import 'package:resipal/domain/use_cases/fetch_user.dart';
import 'package:resipal/domain/use_cases/get_communities.dart';
import 'package:resipal/domain/use_cases/get_user.dart';
import 'package:resipal/domain/use_cases/join_community.dart';
import 'package:resipal/presentation/users/user_onboarding/join_community/user_onboarding_join_community_state.dart';

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
      await JoinCommunity().call(JoinCommunityCommand());
      await FetchUser().call(userId);
      final user = GetUser().call(userId);

      emit(JoinedCommunitySuccessfully(community: community, user: user));
    } catch (e, s) {
      _logger.logException(
        exception: e,
        featureArea: 'UserOnboardingJoinCommunityCubit.onCommunitySelected',
        stackTrace: s,
        metadata: {'community': community},
      );

      emit(ErrorState());
    }
  }
}
