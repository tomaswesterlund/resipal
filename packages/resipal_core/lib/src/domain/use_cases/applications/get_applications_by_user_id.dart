import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class GetApplicationsByUserId {
  final ApplicationDataSource _source = GetIt.I<ApplicationDataSource>();
  final GetApplicationById _getApplicationById = GetApplicationById();

  List<ApplicationEntity> call({required String userId}) {
    final models = _source.getByUserId(userId);
    return models.map((x) => _getApplicationById.call(id: x.id)).toList();

  }
}
