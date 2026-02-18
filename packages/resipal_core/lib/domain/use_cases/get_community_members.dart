import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/community_member_data_source.dart';
import 'package:resipal_core/domain/entities/memberships/community_member_entity.dart';
import 'package:resipal_core/domain/use_cases/get_community_member.dart';

class GetCommunityMembers {
  final MembershipDataSource _source = GetIt.I<MembershipDataSource>();

  List<MembershipEntity> call(String communityId) {
    final members = _source.getByCommunityId(communityId);
    final list = members.map((m) => GetCommunityMember().call(m.id)).toList();
    return list;
  }
}
