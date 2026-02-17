import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/community_application_data_source.dart';

class CreateCommunityApplication {
  final CommunityApplicationDataSource _source = GetIt.I<CommunityApplicationDataSource>();

  Future call({required String communityId, required String userId}) async =>
      _source.createCommunityApplication(communityId: communityId, userId: userId);
}
