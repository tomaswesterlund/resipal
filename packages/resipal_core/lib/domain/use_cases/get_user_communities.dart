import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/community_member_data_source.dart';
import 'package:resipal_core/domain/entities/community/community_entity.dart';
import 'package:resipal_core/domain/use_cases/get_community.dart';

class GetUserCommunities {
  final MembershipDataSource _source = GetIt.I<MembershipDataSource>();

  List<CommunityEntity> call(String userId) {
    final memberships = _source.getByCommunityId(userId);
    final communities = memberships.map((m) => GetCommunity().call(m.communityId)).toList();
    return communities;
  }
}
