import 'package:get_it/get_it.dart';
import 'package:resipal/data/sources/community_application_data_source.dart';

class UserHasJoinedCommunity {
  final CommunityApplicationDataSource _source = GetIt.I<CommunityApplicationDataSource>();

  bool call(String userId) {
    final applications = _source.getByUserId(userId);

    if (applications.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}
