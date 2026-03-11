import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class GetApplicationsByCommunityId {
  final ApplicationDataSource _source = GetIt.I<ApplicationDataSource>();
  final GetApplicationById _getApplicationById = GetApplicationById();

  List<ApplicationEntity> call({required String communityId}) {
    final models = _source.getByCommunityId(communityId);
    return models.map((x) => _getApplicationById.call(id: x.id)).toList();

  }
}
