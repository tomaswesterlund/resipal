import 'package:equatable/equatable.dart';
import 'package:resipal_core/lib.dart';

 abstract class ConfirmPaymentState extends Equatable {
  @override
  List<Object?> get props => [];
 }

class ConfirmPaymentInitialState extends ConfirmPaymentState {}

class ConfirmPaymentLoadingState extends ConfirmPaymentState {}

class ConfirmPaymentLoadedState extends ConfirmPaymentState {
  final PaymentEntity payment;

  ConfirmPaymentLoadedState(this.payment);

  @override
  List<Object?> get props => [payment];
}

class ConfirmPaymentSubmittingState extends ConfirmPaymentState {}

class ConfirmPaymentSubmittedSuccessfullyState extends ConfirmPaymentState {}

class ConfirmPaymentErrorState extends ConfirmPaymentState {}
