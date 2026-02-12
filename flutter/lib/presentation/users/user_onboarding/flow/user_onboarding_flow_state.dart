import 'package:equatable/equatable.dart';
import 'package:resipal/domain/entities/community_entity.dart';

abstract class UserOnboardingFlowState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadingState extends UserOnboardingFlowState {}

class UserDataState extends UserOnboardingFlowState {}

class CommunityFlowState extends UserOnboardingFlowState {
  final List<CommunityEntity> communities;

  CommunityFlowState(this.communities);
}

class CompletedState extends UserOnboardingFlowState {}

class ErrorState extends UserOnboardingFlowState {}
