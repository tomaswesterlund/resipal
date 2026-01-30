import 'package:resipal/presentation/payments/register_payment/register_payment_form_state.dart';

abstract class RegisterPaymentState {}

class InitialState extends RegisterPaymentState {}

class FormEditingState extends RegisterPaymentState {
  final RegisterPaymentFormState formState;

  FormEditingState(this.formState);
}

class FormSubmittingState extends RegisterPaymentState {}

class FormSubmittedSuccessfullyState extends RegisterPaymentState {}

class ErrorState extends RegisterPaymentState {
  final String errorMessage;
  final Object? exception;

  ErrorState({required this.errorMessage, this.exception});
}
