import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/core/services/session_service.dart';
import 'package:resipal/domain/repositories/payment_repository.dart';

class ApprovePaymentCubit extends Cubit<ApprovePaymentState> {
  final PaymentRepository _paymentRepository = GetIt.I<PaymentRepository>();
  final LoggerService _loggerService = GetIt.I<LoggerService>();

  ApprovePaymentCubit() : super(LoadedState());

  Future submit(String paymentId) async {
    try {
      emit(LoadingState());
      await _paymentRepository.approvePayment(userId: SessionService.signedInUserId, paymentId: paymentId);
      emit(LoadedState());
    } catch (e, stack) {
      _loggerService.logException(
        exception: e,
        featureArea: 'ApprovePaymentCubit.submit',
        stackTrace: stack,
        metadata: {'paymentId': paymentId},
      );

      emit(ErrorState(errorMessage: e.toString(), exception: e));
    }
  }
}

abstract class ApprovePaymentState {}

// class InitialState extends ApprovePaymentState {}

class LoadedState extends ApprovePaymentState {}

class LoadingState extends ApprovePaymentState {}

class ErrorState extends ApprovePaymentState {
  final String errorMessage;
  final Object? exception;

  ErrorState({required this.errorMessage, required this.exception});
}
