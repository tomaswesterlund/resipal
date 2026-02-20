import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/membership_data_source.dart';
import 'package:resipal_core/domain/entities/membership_entity.dart';
import 'package:resipal_core/domain/use_cases/get_membership.dart';

class GetMemberships {
  final MembershipDataSource _source = GetIt.I<MembershipDataSource>();
  final GetMembership _getMembership = GetMembership();

  MembershipEntity byId(String id) {
    final model = _source.getById(id);

    if (model == null) {
      throw Exception('Membership $id not found in cache. Ensure the stream is active.');
    }

    final membership = _getMembership.call(model.id);
    return membership;
  }

  List<MembershipEntity> byCommunityId(String communityIt) {
    final models = _source.getByCommunityId(communityIt);
    final list = models.map((x) => byId(x.id)).toList();
    return list;
  }

  List<MembershipEntity> byUserId(String userId) {
    final models = _source.getByUserId(userId);
    final list = models.map((x) => byId(x.id)).toList();
    return list;
  }
}
