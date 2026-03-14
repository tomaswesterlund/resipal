import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class GetPropertiesByCommunityId {
  final PropertyDataSource _source = GetIt.I<PropertyDataSource>();
  final GetPropertyById _getProperty = GetPropertyById();

  List<PropertyEntity> call(String communityId) {
    final models = _source.getByCommunityId(communityId);
    final payments = models.map((m) => _getProperty.call(m.id)).toList();
    return payments;
  }
}
