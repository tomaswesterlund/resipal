import 'package:equatable/equatable.dart';
import 'package:resipal/domain/entities/user_entity.dart';
import 'package:resipal/presentation/users/user_onboarding/user_data/user_onboarding_user_data_form_state.dart';

class UserOnboardingUserDataState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends UserOnboardingUserDataState {}

class FormEditingState extends UserOnboardingUserDataState {
  final UserOnboardingUserDataFormState formState;

  FormEditingState(this.formState);

  @override
  List<Object?> get props => [formState];
}

class FormSubmittingState extends UserOnboardingUserDataState {}

class FormSubmittedSuccessfullyState extends UserOnboardingUserDataState {
  final UserEntity user;

  FormSubmittedSuccessfullyState(this.user);
}

class ErrorState extends UserOnboardingUserDataState {}
