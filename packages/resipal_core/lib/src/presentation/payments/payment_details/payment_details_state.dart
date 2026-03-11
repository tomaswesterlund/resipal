import 'package:equatable/equatable.dart';
import 'package:resipal_core/lib.dart';

abstract class PaymentDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PaymentDetailsInitialState extends PaymentDetailsState {}

class PaymentDetailsLoadingState extends PaymentDetailsState {}

class PaymentDetailsLoadedState extends PaymentDetailsState {
  final PaymentEntity payment;

  PaymentDetailsLoadedState(this.payment);

  @override
  List<Object?> get props => [payment];
}

class PaymentDetailsErrorState extends PaymentDetailsState {}
