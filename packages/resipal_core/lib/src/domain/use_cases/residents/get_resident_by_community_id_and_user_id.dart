import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/domain/use_cases/invitations/get_invitation_by_community_id_and_user_id.dart';

class GetResidentByCommunityIdAndUserId {
  ResidentMemberEntity call({required String communityId, required String userId}) {
    final community = GetCommunityRefById().call(communityId: communityId);
    final user = GetUserRefById().call(userId: userId);
    final membership = GetMembershipByCommunityIdAndUserId().call(communityId: communityId, userId: userId);

    final payments = GetPayments().byCommunityAndUserId(communityId: communityId, userId: userId);
    final ledger = PaymentLedgerEntity(payments);

    final properties = GetProperties().byByCommunityAndResidentId(communityId: communityId, residentId: userId);
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
