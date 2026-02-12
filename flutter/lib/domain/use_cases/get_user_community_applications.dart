import 'package:get_it/get_it.dart';
import 'package:resipal/data/sources/community_application_data_source.dart';
import 'package:resipal/domain/entities/community_application_entity.dart';
import 'package:resipal/domain/use_cases/get_community_application.dart';

class GetUserCommunityApplications {
  final CommunityApplicationDataSource _source = GetIt.I<CommunityApplicationDataSource>();
  final GetCommunityApplication _getCommunityApplication = GetCommunityApplication();

  List<CommunityApplicationEntity> call(String userId) {
    final models = _source.getByUserId(userId);
    final entities = models.map((model) => _getCommunityApplication.fromModel(model)).toList();
    return entities;
  }
}
