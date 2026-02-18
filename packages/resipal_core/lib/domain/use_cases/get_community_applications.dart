import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/community_application_data_source.dart';
import 'package:resipal_core/domain/entities/community/community_application_entity.dart';
import 'package:resipal_core/domain/use_cases/get_community_application.dart';

class GetCommunityApplications {
  final CommunityApplicationDataSource _source = GetIt.I<CommunityApplicationDataSource>();

  List<CommunityApplicationEntity> byCommunityId(String communityId) {
    final applications = _source.getByCommunityId(communityId);
    final list = applications.map((x) => GetCommunityApplication().fromModel(x)).toList();
    return list;
  }
}
