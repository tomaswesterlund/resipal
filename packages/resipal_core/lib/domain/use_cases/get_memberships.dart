import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/community_member_data_source.dart';
import 'package:resipal_core/domain/entities/memberships/community_member_entity.dart';
import 'package:resipal_core/domain/use_cases/get_community_ref.dart';
import 'package:resipal_core/domain/use_cases/get_user_ref.dart';

class GetMemberships {
  final MembershipDataSource _source = GetIt.I<MembershipDataSource>();
  final GetCommunityRef _getCommunityRef = GetCommunityRef();
  final GetUserRef _getUserRef = GetUserRef();

  MembershipEntity byId(String id) {
    final model = _source.getById(id);

    if (model == null) {
      throw Exception('Membership $id not found in cache. Ensure the stream is active.');
    }

    final community = _getCommunityRef.fromId(model.communityId);
    final user = _getUserRef.fromId(model.userId);

    return MembershipEntity(
      id: model.id,
      createdAt: model.createdAt,
      createdBy: model.createdBy,
      user: user,
      community: community,
      isAdmin: model.isAdmin,
      isResident: model.isResident,
      isSecurity: model.isSecurity,
    );
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
