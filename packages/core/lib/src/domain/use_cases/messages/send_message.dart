import 'package:core/lib.dart';

class SendMessage {
  Future call({
    required String communityId,
    required String userId,
    required ResipalApplication app,
    required String title,
    required String body,
  }) async {
    //TODO: Implement message functionality, for now only Notification
    await CreateNotification().call(communityId: communityId, userId: userId, app: app, title: title, message: body);
  }
}
