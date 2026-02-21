import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal_admin/admin_session_service.dart';
import 'package:resipal_core/domain/use_cases/payments/watch_payments_by_community.dart';
import 'package:resipal_core/services/logger_service.dart';
import 'payment_list_state.dart';

class PaymentListCubit extends Cubit<PaymentListState> {
  final WatchPaymentsByCommunity _watchPayments = WatchPaymentsByCommunity();
  final LoggerService _logger = GetIt.I<LoggerService>();
  final AdminSessionService _sessionService = GetIt.I();

  StreamSubscription? _subscription;

  PaymentListCubit() : super(InitialState());

  void initialize() {
    emit(LoadingState());
    _subscription?.cancel();

    _subscription = _watchPayments
        .call(_sessionService.selectedCommunityId)
        .listen(
          (payments) {
            if (payments.isEmpty) {
              emit(EmptyState());
            } else {
              emit(LoadedState(payments));
            }
          },
          onError: (e, s) {
            _logger.logException(exception: e, stackTrace: s, featureArea: 'PaymentListCubit.initialize');
            emit(ErrorState());
          },
        );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
