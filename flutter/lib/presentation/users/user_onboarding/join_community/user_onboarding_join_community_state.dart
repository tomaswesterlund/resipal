import 'package:resipal/domain/entities/community_entity.dart';
import 'package:resipal/domain/entities/user_entity.dart';

class UserOnboardingJoinCommunityState {}

class InitialState extends UserOnboardingJoinCommunityState {}

class LoadingState extends UserOnboardingJoinCommunityState {}

class LoadedState extends UserOnboardingJoinCommunityState {
  final List<CommunityEntity> communities;

  LoadedState(this.communities);
}

class JoinedCommunitySuccessfully extends UserOnboardingJoinCommunityState {
  final CommunityEntity community;
  final UserEntity user;

  JoinedCommunitySuccessfully({required this.community, required this.user});
}

class ErrorState extends UserOnboardingJoinCommunityState {}
