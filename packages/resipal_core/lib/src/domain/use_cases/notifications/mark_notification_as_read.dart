import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class MarkNotificationAsRead {
  final NotificationDataSource _source = GetIt.I<NotificationDataSource>();

  Future call({required String notificationId}) async {
    // TODO: Check if already read (?)
    await _source.updateReadDate(id: notificationId, readDate: DateTime.now());
  }
}
