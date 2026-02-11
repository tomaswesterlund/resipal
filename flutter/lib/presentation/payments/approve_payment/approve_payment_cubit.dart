import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/core/services/auth_service.dart';
import 'package:resipal/domain/use_cases/approve_payment.dart';

class ApprovePaymentCubit extends Cubit<ApprovePaymentState> {
  final LoggerService _loggerService = GetIt.I<LoggerService>();
  final AuthService _authService = GetIt.I<AuthService>();

  ApprovePaymentCubit() : super(LoadedState());

  Future submit(String paymentId) async {
    try {
      emit(LoadingState());
      await ApprovePayment().call(userId: _authService.getSignedInUserId(), paymentId: paymentId);
      emit(LoadedState());
    } catch (e, stack) {
      _loggerService.logException(
        exception: e,
        featureArea: 'ApprovePaymentCubit.submit',
        stackTrace: stack,
        metadata: {'paymentId': paymentId},
      );

      emit(ErrorState());
    }
  }
}

abstract class ApprovePaymentState {}

// class InitialState extends ApprovePaymentState {}

class LoadedState extends ApprovePaymentState {}

class LoadingState extends ApprovePaymentState {}

class ErrorState extends ApprovePaymentState {}
