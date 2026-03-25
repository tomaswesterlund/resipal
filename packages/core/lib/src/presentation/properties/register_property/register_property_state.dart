import 'package:equatable/equatable.dart';
import 'register_property_form_state.dart';

class RegisterPropertyState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterPropertyInitialState extends RegisterPropertyState {}

class RegisterPropertyFormEditingState extends RegisterPropertyState {
  final RegisterPropertyFormState formState;

  RegisterPropertyFormEditingState(this.formState);

  @override
  List<Object?> get props => [formState];
}

class RegisterPropertyFormSubmittingState extends RegisterPropertyState {}

class RegisterPropertyFormSubmittedSuccessfullyState extends RegisterPropertyState {}

class RegisterPropertyNoContractsFound extends RegisterPropertyState {}

class RegisterPropertyErrorState extends RegisterPropertyState {}
