import 'package:equatable/equatable.dart';
import 'package:resipal_core/lib.dart';

abstract class OnboardingCommunityRegistrationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnboardingCommunityRegistrationInitialState extends OnboardingCommunityRegistrationState {}

class OnboardingCommunityRegistrationFormEditingState extends OnboardingCommunityRegistrationState {
  final OnboardingCommunityRegistrationFormState formstate;

  OnboardingCommunityRegistrationFormEditingState(this.formstate);

  @override
  List<Object?> get props => [formstate];
}

class OnboardingCommunityRegistrationFormSubmittingState extends OnboardingCommunityRegistrationState {}

class OnboardingCommunityRegistrationFormSubmittedSuccessfully extends OnboardingCommunityRegistrationState {
  final CommunityEntity community;
  final UserEntity user;

  OnboardingCommunityRegistrationFormSubmittedSuccessfully({required this.community, required this.user});
}

class OnboardingCommunityRegistrationErrorState extends OnboardingCommunityRegistrationState {}
