import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class WatchNotificationsBySignedInMember {
  final SessionService _sessionService = GetIt.I<SessionService>();
  final NotificationDataSource _source = GetIt.I<NotificationDataSource>();

  Stream<List<NotificationEntity>> call() {
    final ResipalApplication app = _sessionService.app;
    final String communityId = _sessionService.communityId;
    final String userId = _sessionService.userId;

    return _source.watchByCommunityId(communityId).map((models) {
      final filtered = models.where((x) => x.communityId == communityId && x.userId == userId && x.app == app.toString());
      return filtered
          .map(
            (x) => NotificationEntity(
              id: x.id,
              communityId: x.communityId,
              userId: x.userId,
              createdAt: x.createdAt,
              createdBy: x.createdBy,
              app: app,
              title: x.title,
              message: x.message,
              readDate: x.readDate,
            ),
          )
          .toList();
    });
  }
}
