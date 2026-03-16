import 'package:resipal_core/lib.dart';

class AdminMemberEntity extends MemberEntity {
  final List<NotificationEntity> notifications;

  List<NotificationEntity> get unreadNotifications => notifications.where((x) => x.readDate == null).toList();

  AdminMemberEntity({
    required super.name,
    required super.community,
    required super.user,
    required super.isAdmin,
    required super.isResident,
    required super.isSecurity,
    required this.notifications,
  });
}
