import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/community_application_data_source.dart';

class FetchCommunityApplications {
  final CommunityApplicationDataSource _source = GetIt.I<CommunityApplicationDataSource>();

  Future byUserId(String userId) async {
    // TODO: Implemetn for "userId" only
    await _source.fetchAndCacheAll();
  }
}