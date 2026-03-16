import 'package:flutter/material.dart';
import 'package:resipal_core/src/domain/entities/notification_entity.dart';
import 'package:resipal_core/src/presentation/notifications/notification_card.dart';
import 'package:wester_kit/ui/my_app_bar.dart';

class NotificationsPage extends StatelessWidget {
  final List<NotificationEntity> notifications;

  const NotificationsPage({super.key, required this.notifications});

  @override
  Widget build(BuildContext context) {
    // Sort notifications: Unread first, then by date (newest first)
    final sortedNotifications = List<NotificationEntity>.from(notifications)
      ..sort((a, b) {
        if (a.readDate == null && b.readDate != null) return -1;
        if (a.readDate != null && b.readDate == null) return 1;
        return b.createdAt.compareTo(a.createdAt);
      });

    return Scaffold(
      appBar: MyAppBar(
        title: 'Notificaciones',
        actions: [
          if (notifications.any((n) => n.readDate == null))
            IconButton(
              tooltip: 'Marcar todas como leídas',
              icon: const Icon(Icons.done_all),
              onPressed: () {
                // TODO: Implement Mark All as Read logic
              },
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
                    // TODO: Implement single Mark as Read logic
                  },
                  onTap: () {
                    // TODO: Navigate to detail if necessary
                  },
                );
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
