import 'package:equatable/equatable.dart';
import 'register_application_form_state.dart';

abstract class RegisterApplicationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterApplicationInitialState extends RegisterApplicationState {}

class RegisterApplicationFormEditingState extends RegisterApplicationState {
  final RegisterApplicationFormState formState;

  RegisterApplicationFormEditingState(this.formState);

  @override
  List<Object?> get props => [formState];
}

class RegisterApplicationFormSubmittingState extends RegisterApplicationState {}

class RegisterApplicationFormSubmittedSuccessfullyState extends RegisterApplicationState {}

class RegisterApplicationErrorState extends RegisterApplicationState {}
