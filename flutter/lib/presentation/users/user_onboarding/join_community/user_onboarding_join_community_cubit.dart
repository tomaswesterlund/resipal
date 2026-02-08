import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal/core/services/auth_service.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/domain/entities/community_entity.dart';
import 'package:resipal/domain/repositories/community_repository.dart';
import 'package:resipal/domain/repositories/user_repository.dart';
import 'package:resipal/presentation/users/user_onboarding/join_community/user_onboarding_join_community_state.dart';

class UserOnboardingJoinCommunityCubit extends Cubit<UserOnboardingJoinCommunityState> {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final AuthService _authService = GetIt.I<AuthService>();
  final CommunityRepository _communityRepository = GetIt.I<CommunityRepository>();
  final UserRepository _userRepository = GetIt.I<UserRepository>();

  UserOnboardingJoinCommunityCubit() : super(InitialState());

  Future initialize() async {
    try {
      emit(LoadingState());
      final communities = _communityRepository.getCommunities();
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
      await _communityRepository.joinCommunity(userId: userId, communityId: community.id);

      await _userRepository.fetchUser(userId);
      final user = _userRepository.getUserById(userId);

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
