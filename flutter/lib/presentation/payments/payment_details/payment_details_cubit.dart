import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/domain/use_cases/get_payment.dart';
import 'package:resipal/presentation/payments/payment_details/payment_details_state.dart';

class PaymentDetailsCubit extends Cubit<PaymentDetailsState> {
  final LoggerService _logger = GetIt.I<LoggerService>();

  PaymentDetailsCubit() : super(InitialState());

  Future initialize(String paymentId) async {
    try {
      emit(LoadingState());
      final payment = GetPayment().call(paymentId);
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
