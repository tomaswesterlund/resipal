import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class GetMembershipById {
  final MembershipDataSource _source = GetIt.I<MembershipDataSource>();

  MembershipEntity call(String id) {
    final membership = _source.getById(id);

    if (membership == null) {
      throw Exception('Membership with id $id not found in cache. Ensure the stream is active.');
    }

    final community = GetCommunityRefById().call(communityId: membership.communityId);
    final user = GetUserRefById().call(userId: membership.userId);

    return MembershipEntity(
      id: id,
      community: community,
      user: user,
      createdAt: membership.createdAt,
      createdBy: membership.createdBy,
      isAdmin: membership.isAdmin,
      isResident: membership.isResident,
      isSecurity: membership.isSecurity,
    );
  }
}
