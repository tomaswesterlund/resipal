import 'package:equatable/equatable.dart';
import 'package:core/lib.dart';
import 'package:core/src/domain/entities/members/admin_member_entity.dart';

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
  final AdminMemberEntity admin;
  final CommunityEntity community;
  

  OnboardingCommunityRegistrationFormSubmittedSuccessfully({required this.admin, required this.community});
}

class OnboardingCommunityRegistrationErrorState extends OnboardingCommunityRegistrationState {}
