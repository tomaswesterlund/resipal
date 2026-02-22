import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal_core/domain/use_cases/payments/get_payment_by_id.dart';
import 'payment_details_state.dart';
import 'package:resipal_core/services/logger_service.dart';

class PaymentDetailsCubit extends Cubit<PaymentDetailsState> {
  final LoggerService _logger = GetIt.I<LoggerService>();

  PaymentDetailsCubit() : super(InitialState());

  Future initialize(String paymentId) async {
    try {
      emit(LoadingState());
      final payment = GetPaymentById().call(paymentId);
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
