import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/community_member_data_source.dart';
import 'package:resipal_core/domain/entities/memberships/community_member_entity.dart';
import 'package:resipal_core/domain/use_cases/get_community_ref.dart';
import 'package:resipal_core/domain/use_cases/get_user_ref.dart';

class GetCommunityMembership {
  final MembershipDataSource _source = GetIt.I<MembershipDataSource>();

  MembershipEntity call(String id) {
    final membership = _source.getById(id);

    if (membership == null) {
      throw Exception('Membership $id not found in cache. Ensure the stream is active.');
    }

    final community = GetCommunityRef().fromId(membership.communityId);
    final user = GetUserRef().fromId(membership.userId);

    return MembershipEntity(
      id: membership.id,
      createdAt: membership.createdAt,
      createdBy: membership.createdBy,
      community: community,
      user: user,
      isAdmin: membership.isAdmin,
      isResident: membership.isResident,
      isSecurity: membership.isSecurity,
    );
  }
}
