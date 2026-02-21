import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/application_data_source.dart';
import 'package:resipal_core/domain/entities/application_entity.dart';
import 'package:resipal_core/domain/use_cases/applications/get_application_from_model.dart';

class GetApplicationsByUser {
  final ApplicationDataSource _source = GetIt.I<ApplicationDataSource>();
  final GetApplicationFromModel _getApplication = GetApplicationFromModel();

  List<ApplicationEntity> call(String userId) {
    final models = _source.getByUserId(userId);
    final entities = models.map((x) => _getApplication.call(x)).toList();
    return entities;
  }
}
