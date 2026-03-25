import 'package:equatable/equatable.dart';
import 'register_contract_form_state.dart';

abstract class RegisterContractState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterContractFormEditingState extends RegisterContractState {
  final RegisterContractFormState formState;
  
  RegisterContractFormEditingState(this.formState);

  @override
  List<Object?> get props => [formState];
}

class RegisterContractFormSubmittingState extends RegisterContractState {}

class RegisterContractFormSubmittedSuccessfullyState extends RegisterContractState {}

class RegisterContractErrorState extends RegisterContractState {}
