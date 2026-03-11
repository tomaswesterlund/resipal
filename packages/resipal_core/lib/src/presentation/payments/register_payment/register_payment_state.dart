import 'package:equatable/equatable.dart';
import 'register_payment_form_state.dart';

abstract class RegisterPaymentState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterPaymentInitialState extends RegisterPaymentState {}

class RegisterPaymentNoResidentsFound extends RegisterPaymentState {}

class RegisterPaymentFormEditingState extends RegisterPaymentState {

  final RegisterPaymentFormState formState;

  RegisterPaymentFormEditingState(this.formState);

  @override
  List<Object?> get props => [formState];
}

class RegisterPaymentFormSubmittingState extends RegisterPaymentState {}

class RegisterPaymentFormSubmittedSuccessfullyState extends RegisterPaymentState {}

class RegisterPaymentErrorState extends RegisterPaymentState {}
