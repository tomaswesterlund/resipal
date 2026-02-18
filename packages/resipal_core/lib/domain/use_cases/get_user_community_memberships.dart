import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/community_member_data_source.dart';
import 'package:resipal_core/domain/entities/memberships/community_member_entity.dart';
import 'package:resipal_core/domain/use_cases/get_community_membership.dart';

class GetUserCommunityMemberships {
  final MembershipDataSource _source = GetIt.I<MembershipDataSource>();

  List<MembershipEntity> call(String userId) {
    final models = _source.getByUserId(userId);
    final list = models.map((m) => GetCommunityMembership().call(m.id)).toList();
    return list;
  }
}
