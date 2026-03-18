import 'package:equatable/equatable.dart';
import 'package:resipal_core/lib.dart';

abstract class NotificationsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NotificationsInitialState extends NotificationsState {}

class NotificationsLoadedState extends NotificationsState {
  final List<NotificationEntity> notifications;

  NotificationsLoadedState(this.notifications);

  @override
  List<Object?> get props => [notifications];
}


class NotificationsErrorState extends NotificationsState {}