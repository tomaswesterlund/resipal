import 'package:get_it/get_it.dart';
import 'package:resipal_core/src/data/sources/notification_data_source.dart';
import 'package:resipal_core/src/domain/entities/notification_entity.dart';
import 'package:resipal_core/src/domain/enums/notification_application.dart';

class GetAdminNotificationsByCommunityAndUserId {
  final NotificationDataSource _source = GetIt.I<NotificationDataSource>();

  List<NotificationEntity> call({required String communityId, required String userId}) {
    final models = _source.getAdminNotificationsByCommunityAndUserId(communityId: communityId, userId: userId);
    final entities = models.map(
      (x) => NotificationEntity(
        id: x.id,
        communityId: x.communityId,
        userId: x.userId,
        createdAt: x.createdAt,
        createdBy: x.createdBy,
        app: NotificationApplication.fromString(x.app),
        title: x.title,
        message: x.message,
        readDate: x.readDate,
      ),
    ).toList();

    return entities;
  }
}
