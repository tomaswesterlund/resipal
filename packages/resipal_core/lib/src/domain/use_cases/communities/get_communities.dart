// import 'package:get_it/get_it.dart';
// import 'package:resipal_core/src/data/sources/community_data_source.dart';
// import 'package:resipal_core/src/domain/entities/community/community_entity.dart';
// import 'package:resipal_core/src/domain/use_cases/communities/get_community_by_id.dart';

// class GetCommunities {
//   final CommunityDataSource _communityDataSource = GetIt.I<CommunityDataSource>();
//   final GetCommunityById _getCommunity = GetCommunityById();

//   Future<List<CommunityEntity>> all() async {
//     final models = _communityDataSource.getAll();
//     final list = models.map((x) => _getCommunity.call(x.id)).toList();
//     return list;
//   }

//   List<CommunityEntity> byUserId(String userId) {
//     final memberships = _membershipSource.getByUserId(userId);
//     final communities = memberships.map((m) => _getCommunity.call(m.communityId)).toList();
//     return communities;
//   }
// }
