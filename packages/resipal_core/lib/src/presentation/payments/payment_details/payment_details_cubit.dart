import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class PaymentDetailsCubit extends Cubit<PaymentDetailsState> {
  final LoggerService _logger = GetIt.I<LoggerService>();

  final WatchPaymentById _watchPaymentById = WatchPaymentById();
  StreamSubscription? _streamSubscription;

  PaymentDetailsCubit() : super(PaymentDetailsInitialState());

  Future initialize(PaymentEntity payment) async {
    try {
      emit(PaymentDetailsLoadedState(payment));

      _streamSubscription = _watchPaymentById
          .call(payment.id)
          .listen(
            (payment) async {
              emit(PaymentDetailsLoadedState(payment));
            },
            onError: (e, s) {
              _logger.error(
                featureArea: 'PaymentDetailsCubit.initialize',
                exception: e,
                stackTrace: s,
                metadata: {'payment': payment.toMap()},
              );

              emit(PaymentDetailsErrorState());
            },
          );
    } catch (e, s) {
      _logger.error(
        exception: e,
        featureArea: 'PaymentDetailsCubit.initialize',
        stackTrace: s,
        metadata: {'payment': payment.toMap()},
      );

      emit(PaymentDetailsErrorState());
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
