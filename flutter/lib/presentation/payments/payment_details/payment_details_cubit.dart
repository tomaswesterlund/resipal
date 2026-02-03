import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/domain/repositories/payment_repository.dart';
import 'package:resipal/presentation/payments/payment_details/payment_details_state.dart';

class PaymentDetailsCubit extends Cubit<PaymentDetailsState> {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final PaymentRepository _paymentRepository = GetIt.I<PaymentRepository>();
  late final StreamSubscription _streamSubscription;

  PaymentDetailsCubit() : super(InitialState());

  Future initialize(String paymentId) async {
    try {
      emit(LoadingState());
      _streamSubscription = _paymentRepository
          .watchPaymentById(paymentId)
          .listen(
            (payment) => emit(LoadedState(payment)),
            onError: (error) => emit(
              ErrorState(errorMessage: error.toString(), exception: error),
            ),
          );
    } catch (e, s) {
      _logger.logException(
        exception: e,
        featureArea: 'PaymentDetailsCubit.initialize',
        stackTrace: s,
        metadata: {'paymentId': paymentId},
      );

      emit(ErrorState(errorMessage: e.toString(), exception: e));
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
