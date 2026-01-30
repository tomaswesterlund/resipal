import 'package:equatable/equatable.dart';
import 'package:resipal/domain/entities/payment_entity.dart';

class UserPaymentsState extends Equatable {
  final bool isFetchingPayments;
  final List<PaymentEntity> payments;
  final String? errorMessage;
  final Object? exception;

  bool get isError => errorMessage != null || exception != null;

  const UserPaymentsState({this.isFetchingPayments = true, this.payments = const [], this.errorMessage, this.exception});

  UserPaymentsState copyWith({bool? isFetchingPayments, List<PaymentEntity>? payments, String? errorMessage, Exception? exception}) {
    return UserPaymentsState(
      isFetchingPayments: isFetchingPayments ?? this.isFetchingPayments,
      payments: payments ?? this.payments,
      errorMessage: errorMessage ?? this.errorMessage,
      exception: exception ?? this.exception,
    );
  }

  @override
  List<Object?> get props => [isFetchingPayments, payments, errorMessage, exception];
}
