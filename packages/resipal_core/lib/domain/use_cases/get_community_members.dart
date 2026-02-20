import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/membership_data_source.dart';
import 'package:resipal_core/domain/entities/membership_entity.dart';
import 'package:resipal_core/domain/use_cases/get_membership.dart';

class GetCommunityMembers {
  final MembershipDataSource _source = GetIt.I<MembershipDataSource>();

  List<MembershipEntity> call(String communityId) {
    final members = _source.getByCommunityId(communityId);
    final list = members.map((m) => GetMembership().call(m.id)).toList();
    return list;
  }
}
