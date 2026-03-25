import 'package:get_it/get_it.dart';
import 'package:core/lib.dart';

class WatchApplicationsByEmail {
  final ApplicationDataSource _source = GetIt.I<ApplicationDataSource>();
  final GetApplicationById _getApplicationById = GetApplicationById();

  Stream<List<ApplicationEntity>> call({required String email}) {
    return _source.watchByEmail(email).map((models) {
      final entities = models.map((x) => _getApplicationById.call(id: x.id)).toList();
      return entities;
    });
  }
}
