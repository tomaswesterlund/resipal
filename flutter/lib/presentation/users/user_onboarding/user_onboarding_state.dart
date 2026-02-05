import 'package:equatable/equatable.dart';
import 'package:resipal/domain/entities/user_entity.dart';
import 'package:resipal/presentation/users/user_onboarding/user_onboarding_form_state.dart';

class UserOnboardingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends UserOnboardingState {}

class FormEditingState extends UserOnboardingState {
  final UserOnboardingFormState formState;

  FormEditingState(this.formState);

  @override
  List<Object?> get props => [formState];
}

class FormSubmittingState extends UserOnboardingState {}

class FormSubmittedSuccessfullyState extends UserOnboardingState {
  final UserEntity user;

  FormSubmittedSuccessfullyState(this.user);
}

class ErrorState extends UserOnboardingState {
  final String errorMessage;
  final Object? exception;

  ErrorState({required this.errorMessage, required this.exception});
}
