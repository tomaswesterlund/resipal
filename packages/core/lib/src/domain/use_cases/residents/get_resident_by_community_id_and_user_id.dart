import 'package:core/lib.dart';
import 'package:core/src/domain/entities/access_registery.dart';

class GetResidentByCommunityIdAndUserId {
  ResidentMemberEntity call({required String communityId, required String userId}) {
    final community = GetCommunityRefById().call(communityId: communityId);
    final user = GetUserRefById().call(userId: userId);
    final membership = GetMembershipByCommunityIdAndUserId().call(communityId: communityId, userId: userId);

    final payments = GetPayments().byCommunityAndUserId(communityId: communityId, userId: userId);
    final ledger = PaymentLedgerEntity(payments);

    final invitations = GetInvitationsByCommunityIdAndUserId().call(communityId: communityId, userId: userId);
    final notifications = GetNotificationsByCommunityAndUserId().call(
      communityId: communityId,
      userId: userId,
      app: ResipalApplication.resident,
    );
    final properties = GetPropertiesByCommunityAndResidentId().call(communityId: communityId, residentId: userId);
    final registry = PropertyRegistry(properties);
    final visitors = GetVisitorsByCommunityIdAndUserId().call(communityId: communityId, userId: userId);

    return ResidentMemberEntity(
      name: user.name,
      community: community,
      user: user,
      accessRegistry: AccessRegistry(invitations: invitations, visitors: visitors),
      paymentLedger: ledger,
      propertyRegistry: registry,
      isAdmin: membership.isAdmin,
      isResident: membership.isResident,
      isSecurity: membership.isSecurity,
      notifications: notifications,
    );
  }
}
