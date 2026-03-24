import 'package:equatable/equatable.dart';
import 'package:resipal_core/lib.dart';

abstract class ResidentOnboardingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ResidentOnboardingInitialState extends ResidentOnboardingState {}

class ResidentOnboardingFormEditingState extends ResidentOnboardingState {
  final ResidentOnboardingFormState formstate;

  ResidentOnboardingFormEditingState(this.formstate);

  @override
  List<Object?> get props => [formstate];
}

class ResidentOnboardingFormSubmittingState extends ResidentOnboardingState {}

class ResidentOnboardingFormSubmittedSuccessfully extends ResidentOnboardingState {
  final UserEntity user;

  ResidentOnboardingFormSubmittedSuccessfully({required this.user});
}

class ResidentOnboardingErrorState extends ResidentOnboardingState {}
