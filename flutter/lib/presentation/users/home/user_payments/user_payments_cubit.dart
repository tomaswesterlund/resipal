import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/domain/entities/payment_entity.dart';
import 'package:resipal/domain/repositories/payment_repository.dart';
import 'package:resipal/presentation/users/home/user_payments/user_payments_state.dart';

class UserPaymentsCubit extends Cubit<UserPaymentsState> {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final PaymentRepository _paymentRepository = GetIt.I<PaymentRepository>();
  StreamSubscription<List<PaymentEntity>>? _streamSubscription;

  UserPaymentsCubit() : super(UserPaymentsState());

  Future intialize(String userId) async {
    try {
      await _streamSubscription?.cancel();
      emit(state.copyWith(isFetchingPayments: true));

      _streamSubscription = _paymentRepository
          .watchPaymentsByUserId(userId)
          .listen(
            (payments) {
              payments.sort((a, b) => b.date.compareTo(a.date));
              emit(UserPaymentsState(isFetchingPayments: false, payments: payments));
            },
            onError: (e, s) {
              _logger.logException(exception: e, featureArea: 'UserPaymentsCubit.intialize', stackTrace: s);
              emit(UserPaymentsState(errorMessage: e.toString(), exception: e));
            },
          );
    } catch (e, s) {
      _logger.logException(exception: e, featureArea: 'UserPaymentsCubit.intialize', stackTrace: s);
      emit(UserPaymentsState(errorMessage: e.toString(), exception: e));
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
