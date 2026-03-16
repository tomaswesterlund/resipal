import 'package:resipal_core/src/domain/enums/notification_application.dart';

class NotificationEntity {
  final String id;
  final String communityId;
  final String userId;
  final DateTime createdAt;
  final String createdBy;
  final NotificationApplication app;
  final String title;
  final String message;
  final DateTime? readDate;

  NotificationEntity({
    required this.id,
    required this.communityId,
    required this.userId,
    required this.createdAt,
    required this.createdBy,
    required this.app,
    required this.title,
    required this.message,
    required this.readDate,
  });
}
