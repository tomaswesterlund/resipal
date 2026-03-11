import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/presentation/payments/confirm_payment/confirm_payment_state.dart';

class ConfirmPaymentCubit extends Cubit<ConfirmPaymentState> {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final SessionService _sessionService = GetIt.I<SessionService>();

  ConfirmPaymentCubit() : super(ConfirmPaymentInitialState());

  void initialize(String paymentId) {
    try {
      emit(ConfirmPaymentLoadingState());

      WatchPaymentById()
          .call(paymentId)
          .listen(
            (payment) {
              emit(ConfirmPaymentLoadedState(payment));
            },
            onError: (e, s) {
              _logger.error(
                exception: e,
                featureArea: 'ConfirmPaymentCubit.',
                stackTrace: s,
                metadata: {'paymentId': paymentId},
              );
              emit(ConfirmPaymentErrorState());
            },
          );
    } catch (e, s) {
      _logger.error(
        exception: e,
        featureArea: 'ConfirmPaymentCubit.',
        stackTrace: s,
        metadata: {'paymentId': paymentId},
      );
      emit(ConfirmPaymentErrorState());
    }
  }

  Future submit(PaymentEntity payment) async {
    try {
      await ConfirmPaymentReceived().call(paymentId: payment.id);
      final updatedPayment = await FetchPaymentById().call(payment.id);
      emit(ConfirmPaymentLoadedState(updatedPayment));
    } catch (e, s) {
      _logger.error(
        exception: e,
        featureArea: 'PaymentDetailsCubit.confirmPaymentReceived',
        stackTrace: s,
        metadata: payment.toMap(),
      );
    }
  }
}
