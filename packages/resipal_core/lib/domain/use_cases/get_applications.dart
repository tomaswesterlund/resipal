import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/application_data_source.dart';
import 'package:resipal_core/domain/entities/application_entity.dart';
import 'package:resipal_core/domain/use_cases/get_application.dart';

class GetApplications {
  final ApplicationDataSource _source = GetIt.I<ApplicationDataSource>();
  final GetApplication _getCommunityApplication = GetApplication();

  List<ApplicationEntity> byCommunityId(String communityId) {
    final applications = _source.getByCommunityId(communityId);
    final list = applications.map((x) => _getCommunityApplication.fromModel(x)).toList();
    return list;
  }

  List<ApplicationEntity> byUserId(String userId) {
    final models = _source.getByUserId(userId);
    final entities = models.map((x) => _getCommunityApplication.fromModel(x)).toList();
    return entities;
  }
}
