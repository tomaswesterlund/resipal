import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/domain/repositories/payment_repository.dart';
import 'package:resipal/presentation/payments/payment_details/payment_details_state.dart';

class PaymentDetailsCubit extends Cubit<PaymentDetailsState> {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final PaymentRepository _paymentRepository = GetIt.I<PaymentRepository>();

  PaymentDetailsCubit() : super(InitialState());

  Future initialize(String paymentId) async {
    try {
      emit(LoadingState());
      final payment = _paymentRepository.getPaymentById(paymentId);
      emit(LoadedState(payment));
    } catch (e, s) {
      _logger.logException(
        exception: e,
        featureArea: 'PaymentDetailsCubit.initialize',
        stackTrace: s,
        metadata: {'paymentId': paymentId},
      );

      emit(ErrorState());
    }
  }
}
