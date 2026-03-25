import 'package:get_it/get_it.dart';
import 'package:core/lib.dart';
import 'package:core/src/domain/enums/resipal_application.dart';

class CreateNotification {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final NotificationDataSource _source = GetIt.I<NotificationDataSource>();

  Future call({
    required String communityId,
    required String userId,
    required ResipalApplication app,
    required String title,
    required String message,
  }) async {
    try {
      final model = UpsertNotificationModel(
        communityId: communityId,
        userId: userId,
        app: app.toString(),
        title: title,
        message: message,
        readDate: null,
      );
      await _source.upsert(model);
    } catch (e, s) {
      _logger.error(featureArea: 'CreateNotification', exception: e, stackTrace: s);
    }
  }
}
