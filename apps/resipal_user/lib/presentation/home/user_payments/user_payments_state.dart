import 'package:equatable/equatable.dart';
import 'package:resipal_core/domain/entities/payment/payment_entity.dart';

abstract class UserPaymentsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends UserPaymentsState {}

class LoadingState extends UserPaymentsState {}

class LoadedState extends UserPaymentsState {
  final List<PaymentEntity> payments;

  LoadedState(this.payments);

  @override
  List<Object?> get props => [payments];
}

class ErrorState extends UserPaymentsState {}
