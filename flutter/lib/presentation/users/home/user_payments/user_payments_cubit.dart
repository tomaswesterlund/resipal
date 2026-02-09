import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/domain/repositories/payment_repository.dart';
import 'package:resipal/presentation/users/home/user_payments/user_payments_state.dart';

class UserPaymentsCubit extends Cubit<UserPaymentsState> {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final PaymentRepository _paymentRepository = GetIt.I<PaymentRepository>();
  late final StreamSubscription? _streamSubscription;

  UserPaymentsCubit() : super(InitialState());

  Future intialize(String userId) async {
    try {
      emit(LoadingState());

      _streamSubscription = _paymentRepository
          .watchPaymentsByUserId(userId)
          .listen(
            (payments) => emit(LoadedState(payments)),
            onError: (e, s) {
              _logger.logException(exception: e, featureArea: 'UserPaymentsCubit.intialize', stackTrace: s);
              emit(ErrorState());
            },
          );
    } catch (e, s) {
      _logger.logException(exception: e, featureArea: 'UserPaymentsCubit.intialize', stackTrace: s);
      emit(ErrorState());
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
