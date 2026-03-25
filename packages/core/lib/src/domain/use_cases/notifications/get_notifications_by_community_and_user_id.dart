import 'package:get_it/get_it.dart';
import 'package:core/src/data/sources/notification_data_source.dart';
import 'package:core/src/domain/entities/notification_entity.dart';
import 'package:core/src/domain/enums/resipal_application.dart';

class GetNotificationsByCommunityAndUserId {
  final NotificationDataSource _source = GetIt.I<NotificationDataSource>();

  List<NotificationEntity> call({
    required String communityId,
    required String userId,
    required ResipalApplication app,
  }) {
    final models = _source.getNotificationsByCommunityAndUserId(
      communityId: communityId,
      userId: userId,
      app: app.toString(),
    );
    final entities = models
        .map(
          (x) => NotificationEntity(
            id: x.id,
            communityId: x.communityId,
            userId: x.userId,
            createdAt: x.createdAt,
            createdBy: x.createdBy,
            app: ResipalApplication.fromString(x.app),
            title: x.title,
            message: x.message,
            readDate: x.readDate,
          ),
        )
        .toList();

    return entities;
  }
}
