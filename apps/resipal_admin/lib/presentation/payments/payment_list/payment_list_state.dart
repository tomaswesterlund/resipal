import 'package:equatable/equatable.dart';
import 'package:resipal_core/domain/entities/payment/payment_entity.dart';

abstract class PaymentListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends PaymentListState {}

class LoadingState extends PaymentListState {}

class LoadedState extends PaymentListState {
  final List<PaymentEntity> payments;
  LoadedState(this.payments);

  @override
  List<Object?> get props => [payments];
}

class EmptyState extends PaymentListState {}

class ErrorState extends PaymentListState {}
