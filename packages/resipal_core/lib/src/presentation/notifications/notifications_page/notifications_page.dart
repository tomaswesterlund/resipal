import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/presentation/notifications/notification_card.dart';
import 'package:resipal_core/src/presentation/notifications/notifications_page/notifications_cubit.dart';
import 'package:resipal_core/src/presentation/notifications/notifications_page/notifications_state.dart';
import 'package:wester_kit/ui/my_app_bar.dart';

class NotificationsPage extends StatelessWidget {
  final List<NotificationEntity> notifications;
  const NotificationsPage(this.notifications, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotificationsCubit>(
      create: (context) => NotificationsCubit()..initialize(notifications),
      child: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) {
          if (state is NotificationsInitialState) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          if (state is NotificationsErrorState) {
            return const Scaffold(body: Center(child: Text('Error al cargar notificaciones')));
          }

          if (state is NotificationsLoadedState) {
            final notifications = state.notifications;

            // Sort notifications: Unread first, then by date (newest first)
            final sortedNotifications = List<NotificationEntity>.from(notifications)
              ..sort((a, b) {
                if (a.readDate == null && b.readDate != null) return -1;
                if (a.readDate != null && b.readDate == null) return 1;
                return b.createdAt.compareTo(a.createdAt);
              });

            final unreadNotifications = notifications.where((n) => n.readDate == null).toList();

            return Scaffold(
              appBar: MyAppBar(
                title: 'Notificaciones',
                actions: [
                  if (unreadNotifications.isNotEmpty)
                    IconButton(
                      tooltip: 'Marcar todas como leídas',
                      icon: const Icon(Icons.done_all),
                      onPressed: () => context.read<NotificationsCubit>().markAllAsRead(),
                    ),
                ],
              ),
              body: sortedNotifications.isEmpty
                  ? const _EmptyNotifications()
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      itemCount: sortedNotifications.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 4),
                      itemBuilder: (context, index) {
                        final notification = sortedNotifications[index];

                        return NotificationCard(
                          notification: notification,
                          onMarkAsRead: () {
                            MarkNotificationAsRead().call(notificationId: notification.id);
                          },
                          onTap: () {
                            // TODO: Navigate to specific entity (Payment, etc) based on notification data
                          },
                        );
                      },
                    ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _EmptyNotifications extends StatelessWidget {
  const _EmptyNotifications();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_none_outlined, size: 64, color: colorScheme.outlineVariant),
          const SizedBox(height: 16),
          Text(
            'No hay notificaciones',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: colorScheme.outline),
          ),
        ],
      ),
    );
  }
}
