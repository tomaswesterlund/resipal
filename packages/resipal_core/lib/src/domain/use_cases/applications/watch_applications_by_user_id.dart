import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class WatchApplicationsByUserId {
  final ApplicationDataSource _source = GetIt.I<ApplicationDataSource>();
  final GetApplicationById _getApplicationById = GetApplicationById();

  Stream<List<ApplicationEntity>> call({required String userId}) {
    return _source.watchByUserId(userId).map((models) {
      final entities = models.map((x) => _getApplicationById.call(id: x.id)).toList();
      return entities;
    });
  }
}
