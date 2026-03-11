import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class GetMemberByUserAndCommunityId {
  final MembershipDataSource _source = GetIt.I<MembershipDataSource>();

  MemberEntity call({required String communityId, required String userId}) {
    final membership = _source.getByCommunityAndUserId(communityId: communityId, userId: userId);
    final communityRef = GetCommunityRefById().call(communityId: communityId);
    final userRef = GetUserRefById().call(userId: userId);
    final payments = GetPaymentByUserId().call(userId: userId);
    final properties = GetPropertiesByResidentId().call(residentId: userId);

    return MemberEntity(
      name: userRef.name,
      community: communityRef,
      user: userRef,
      paymentLedger: PaymentLedgerEntity(payments),
      propertyRegistry: PropertyRegistry(properties),
      isAdmin: membership.isAdmin,
      isResident: membership.isResident,
      isSecurity: membership.isSecurity,
    );
  }
}
