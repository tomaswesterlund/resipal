import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/domain/entities/payment_entity.dart';
import 'package:resipal/domain/repositories/payment_repository.dart';

class PaymentHeaderCubit extends Cubit<PaymentHeaderState> {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final PaymentRepository _paymentRepository = GetIt.I<PaymentRepository>();

  PaymentHeaderCubit() : super(InitialState());

  void initialize(String paymentId) {
    try {
      emit(LoadingState());

      _paymentRepository
          .watchPaymentById(paymentId)
          .listen(
            (payment) => emit(LoadedState(payment)),
            onError: (error) => emit(
              ErrorState(errorMessage: error.toString(), exception: error),
            ),
          );
    } catch (e, stack) {
      _logger.logException(
        exception: e,
        featureArea: 'PaymentHeaderCubit.initialize',
        stackTrace: stack,
        metadata: {'paymentId': paymentId},
      );
      emit(ErrorState(errorMessage: e.toString(), exception: e));
    }
  }
}

abstract class PaymentHeaderState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends PaymentHeaderState {}

class LoadingState extends PaymentHeaderState {}

class LoadedState extends PaymentHeaderState {
  final PaymentEntity payment;

  LoadedState(this.payment);

  @override
  List<Object?> get props => [payment];
}

class ErrorState extends PaymentHeaderState {
  final String errorMessage;
  final Object? exception;

  ErrorState({required this.errorMessage, this.exception});
}
