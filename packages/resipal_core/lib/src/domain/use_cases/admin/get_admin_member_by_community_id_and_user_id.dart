import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/domain/entities/members/admin_member_entity.dart';
import 'package:resipal_core/src/domain/use_cases/notifications/get_admin_notifications_by_community_and_user_id.dart';

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
    final notifications = GetAdminNotificationsByCommunityAndUserId().call(communityId: communityId, userId: userId);
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
