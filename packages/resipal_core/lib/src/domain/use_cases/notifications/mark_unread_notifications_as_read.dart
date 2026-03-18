import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class MarkUnreadNotificationsAsRead {
  final NotificationDataSource _source = GetIt.I<NotificationDataSource>();
  final LoggerService _logger = GetIt.I<LoggerService>();

  Future<void> call({required String communityId, required String userId}) async {
    try {
      await _source.markAllAsRead(communityId: communityId, userId: userId, readDate: DateTime.now());
    } catch (e, s) {
      await _logger.error(featureArea: 'MarkUnreadNotificationsAsRead', exception: e, stackTrace: s);
    }
  }
}
