import 'package:equatable/equatable.dart';
import 'package:resipal_core/lib.dart';

abstract class OnboardingUserRegistrationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnboardingUserRegistrationInitialState extends OnboardingUserRegistrationState {}

class OnboardingUserRegistrationFormEditingState extends OnboardingUserRegistrationState {
  final OnboardingUserRegistrationFormState formstate;

  OnboardingUserRegistrationFormEditingState(this.formstate);

  @override
  List<Object?> get props => [formstate];
}

class OnboardingUserRegistrationFormSubmittingState extends OnboardingUserRegistrationState {}

class OnboardingUserRegistrationFormSubmittedSuccessfully extends OnboardingUserRegistrationState {}

class OnboardingUserRegistrationErrorState extends OnboardingUserRegistrationState {}
