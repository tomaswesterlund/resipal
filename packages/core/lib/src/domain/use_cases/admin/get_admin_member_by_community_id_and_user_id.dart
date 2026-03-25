import 'package:get_it/get_it.dart';
import 'package:core/lib.dart';
import 'package:core/src/domain/enums/resipal_application.dart';

class GetAdminMemberByCommunityIdAndUserId {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final MembershipDataSource _source = GetIt.I<MembershipDataSource>();

  AdminMemberEntity call({required String communityId, required String userId}) {
    final membership = _source.getByCommunityAndUserId(communityId: communityId, userId: userId);

    if (membership.isAdmin == false) {
      _logger.error(
        featureArea: 'GetAdminMemberByCommunityIdAndUserId',
        exception: 'User with id ${userId} for community with id ${communityId} is not admin.',
      );
      throw Exception('User is not admin within this community.');
    }

    final communityRef = GetCommunityRefById().call(communityId: communityId);
    final notifications = GetNotificationsByCommunityAndUserId().call(communityId: communityId, userId: userId, app: ResipalApplication.admin);
    final userRef = GetUserRefById().call(userId: userId);

    return AdminMemberEntity(
      name: userRef.name,
      community: communityRef,
      user: userRef,
      isAdmin: membership.isAdmin,
      isResident: membership.isResident,
      isSecurity: membership.isSecurity,
      notifications: notifications,
    );
  }
}
