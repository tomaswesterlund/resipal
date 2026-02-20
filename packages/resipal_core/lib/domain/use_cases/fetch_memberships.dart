import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/membership_data_source.dart';

class FetchMemberships {
  final MembershipDataSource _source = GetIt.I<MembershipDataSource>();

  Future byCommunityId(String communityId) async {
    // TODO: Implemetn for "communityId" only
    await _source.fetchAndCacheAll();
  }

  Future byUserId(String userId) async {
    // TODO: Implemetn for "userId" only
    await _source.fetchAndCacheAll();
  }
}
