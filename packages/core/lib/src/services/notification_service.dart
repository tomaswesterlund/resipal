import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:core/lib.dart';
import 'package:core/src/domain/use_cases/notifications/update_firebase_cloud_messaging_token.dart';

class NotificationService {
  final LoggerService _logger = GetIt.I<LoggerService>();

  Future initialize({required String userId}) async {
    try {
      NotificationSettings? notificationSettings;
      if (Platform.isIOS) {
        final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
        if (apnsToken != null) {
          notificationSettings = await FirebaseMessaging.instance.requestPermission(provisional: true);
        }
      } else if (Platform.isAndroid) {
        notificationSettings = await FirebaseMessaging.instance.requestPermission(provisional: true);
      }

      String? fcmToken = await FirebaseMessaging.instance.getToken();

      if (fcmToken != null) {
        await UpdateFirebaseCloudMessagingToken().call(fcmToken: fcmToken);
      }

      FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async {
        await UpdateFirebaseCloudMessagingToken().call(fcmToken: fcmToken);
      });
    } catch (e, s) {
      _logger.error(featureArea: 'NotificationService', exception: e, stackTrace: s);
      // Do not rethrow, should not crash application!
    }
  }
}
