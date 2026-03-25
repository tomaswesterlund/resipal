import 'package:get_it/get_it.dart';
import 'package:core/lib.dart';

class WatchAdminMemberByCommunityAndUserId {
  final NotificationDataSource _notificationDataSource = GetIt.I<NotificationDataSource>();

  Stream<AdminMemberEntity> call({required String communityId, required String userId}) {
    return _notificationDataSource.watchByUserId(userId).map((x) {
      final admin = GetAdminMemberByCommunityIdAndUserId().call(communityId: communityId, userId: userId);
      return admin;
    });
  }
}