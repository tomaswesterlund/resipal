import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:core/lib.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final SessionService _sessionService = GetIt.I<SessionService>();
  NotificationsCubit() : super(NotificationsInitialState());

  StreamSubscription? _streamSubscription;

  initialize(List<NotificationEntity> notifications) {
    try {
      emit(NotificationsLoadedState(notifications));

      _streamSubscription = WatchNotificationsBySignedInMember()
          .call()
          .listen(
            (notifications) => emit(NotificationsLoadedState(notifications)),
            onError: (e, s) {
              _logger.error(featureArea: 'NotificationsCubit', exception: e, stackTrace: s);
              emit(NotificationsErrorState());
            },
          );
    } catch (e, s) {
      _logger.error(featureArea: 'NotificationsCubit', exception: e, stackTrace: s);
      emit(NotificationsErrorState());
    }
  }

  Future markAllAsRead() async {
    await MarkUnreadNotificationsAsRead().call(communityId: _sessionService.communityId, userId: _sessionService.userId);
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
