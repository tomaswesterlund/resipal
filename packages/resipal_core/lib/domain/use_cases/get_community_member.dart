import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/community_member_data_source.dart';
import 'package:resipal_core/domain/entities/memberships/community_member_entity.dart';
import 'package:resipal_core/domain/use_cases/get_community_ref.dart';
import 'package:resipal_core/domain/use_cases/get_user.dart';
import 'package:resipal_core/domain/use_cases/get_user_ref.dart';

class GetCommunityMember {
  final MembershipDataSource _source = GetIt.I<MembershipDataSource>();

  MembershipEntity call(String id)  {
    final member = _source.getById(id);

    if (member == null) {
      throw Exception('Community $id not found in cache. Ensure the stream is active.');
    }

    final community = GetCommunityRef().fromId(member.communityId);
    final user = GetUserRef().fromId(member.userId);

    return MembershipEntity(
      id: member.id,
      createdAt: member.createdAt,
      createdBy: member.createdBy,
      user: user,
      community: community,
      isAdmin: member.isAdmin,
      isResident: member.isResident,
      isSecurity: member.isSecurity,
    );
  }
}
