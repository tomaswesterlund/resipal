import 'package:resipal_core/lib.dart';

class GetResidentByCommunityIdAndUserId {
  ResidentMemberEntity call({required String communityId, required String userId}) {
    final community = GetCommunityRefById().call(communityId: communityId);
    final user = GetUserRefById().call(userId: userId);
    final membership = GetMembershipByCommunityIdAndUserId().call(communityId: communityId, userId: userId);

    final payments = GetPayments().byCommunityAndUserId(communityId: communityId, userId: userId);
    final ledger = PaymentLedgerEntity(payments);

    final properties = GetPropertiesByCommunityAndResidentId().call(communityId: communityId, residentId: userId);
    final registry = PropertyRegistry(properties);
    final invitations = GetInvitationByCommunityIdAndUserId().call(communityId: communityId, userId: userId);
    final visitors = GetVisitorsByCommunityIdAndUserId().call(communityId: communityId, userId: userId);

    return ResidentMemberEntity(
      name: user.name,
      community: community,
      user: user,
      paymentLedger: ledger,
      propertyRegistry: registry,
      isAdmin: membership.isAdmin,
      isResident: membership.isResident,
      isSecurity: membership.isSecurity,
      invitations: invitations,
      visitors: visitors,
    );
  }
}
