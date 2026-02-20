import 'package:equatable/equatable.dart';
import 'package:resipal_admin/presentation/onboarding/registration/onboarding_registration_form_state.dart';

abstract class OnboardingRegistrationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends OnboardingRegistrationState {}

class FormEditingState extends OnboardingRegistrationState {
  final OnboardingRegistrationFormState formstate;

  FormEditingState(this.formstate);

  @override
  List<Object?> get props => [formstate];
}

class FormSubmittingState extends OnboardingRegistrationState {}

class FormSubmittedSuccessfully extends OnboardingRegistrationState {}

class ErrorState extends OnboardingRegistrationState {}
