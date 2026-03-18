import 'package:flutter/material.dart';
import 'package:resipal_core/src/domain/entities/notification_entity.dart';
import 'package:wester_kit/lib.dart';
import 'package:intl/intl.dart';

class NotificationCard extends StatelessWidget {
  final NotificationEntity notification;
  final VoidCallback? onMarkAsRead;
  final VoidCallback? onTap;
  final bool isSubmitting; // Added isSubmitting property

  const NotificationCard({
    super.key,
    required this.notification,
    this.onMarkAsRead,
    this.onTap,
    this.isSubmitting = false, // Default to false
  });

  bool get isRead => notification.readDate != null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isRead ? colorScheme.outlineVariant : colorScheme.primary.withOpacity(0.5),
          width: isRead ? 1 : 1.5,
        ),
      ),
      color: isRead ? colorScheme.surface : colorScheme.primaryContainer.withOpacity(0.05),
      child: InkWell(
        onTap: isSubmitting ? null : onTap, // Disable tap while submitting
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _StatusIndicator(isRead: isRead, isSubmitting: isSubmitting),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeaderText.five(
                          notification.title,
                          color: isRead ? colorScheme.onSurface : colorScheme.primary,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          DateFormat('MMM dd, yyyy • hh:mm a').format(notification.createdAt),
                          style: theme.textTheme.labelSmall?.copyWith(color: colorScheme.outline),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              BodyText.medium(notification.message, color: colorScheme.onSurfaceVariant),

              // Logic for Mark as Read button with Loading State
              if (!isRead && onMarkAsRead != null) ...[
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: isSubmitting
                      ? const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          child: SizedBox(height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2)),
                        )
                      : TextButton.icon(
                          onPressed: onMarkAsRead,
                          icon: const Icon(Icons.done_all, size: 18),
                          label: const Text('Marcar como leída'),
                          style: TextButton.styleFrom(
                            foregroundColor: colorScheme.primary,
                            visualDensity: VisualDensity.compact,
                          ),
                        ),
                ),
              ],

              if (isRead) ...[
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle, size: 12, color: colorScheme.outline),
                      const SizedBox(width: 4),
                      Text(
                        'Leído el ${DateFormat('dd/MM/yy').format(notification.readDate!)}',
                        style: theme.textTheme.labelSmall?.copyWith(color: colorScheme.outline),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusIndicator extends StatelessWidget {
  final bool isRead;
  final bool isSubmitting;

  const _StatusIndicator({required this.isRead, required this.isSubmitting});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isRead
            ? colorScheme.surfaceVariant.withOpacity(0.5)
            : (isSubmitting ? colorScheme.outlineVariant : colorScheme.primary.withOpacity(0.1)),
        shape: BoxShape.circle,
      ),
      child: isSubmitting
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2, color: colorScheme.primary.withOpacity(0.5)),
            )
          : Icon(
              isRead ? Icons.notifications_none_outlined : Icons.notifications_active,
              color: isRead ? colorScheme.outline : colorScheme.primary,
              size: 20,
            ),
    );
  }
}
