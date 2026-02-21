import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/property_data_source.dart';
import 'package:resipal_core/domain/entities/property_entity.dart';
import 'package:resipal_core/domain/use_cases/properties/get_property_by_id.dart';

class GetProperties {
  final PropertyDataSource _source = GetIt.I<PropertyDataSource>();
  final GetPropertyById _getProperty = GetPropertyById();

  List<PropertyEntity> byCommunityId(String userId) {
    final models = _source.getByCommunityId(userId);
    final payments = models.map((m) => _getProperty.call(m.id)).toList();
    return payments;
  }

  List<PropertyEntity> byResidentId(String userId) {
    final models = _source.getByResidentId(userId);
    final payments = models.map((m) => _getProperty.call(m.id)).toList();
    return payments;
  }

  List<PropertyEntity> byByCommunityAndResidentId({required String communityId, required String residentId}) {
    final properties = _source.getByCommunityAndResidentId(communityId: communityId, residentId: residentId);
    final list = properties.map((x) => _getProperty.call(x.id)).toList();
    return list;
  }
}
